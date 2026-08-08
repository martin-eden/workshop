-- Unquote Lua string that is quoted with backslashes

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

-- Imports:
local AsciiChars = request('!.concepts.Ascii.Chars')
local separator = AsciiChars.backslash

local str_to_int = tonumber
local str_char = string.char
local utf8_char = utf8.char
local str_find = string.find
local str_sub = string.sub

-- Decodes that magic sequences "\f", "\v", etc
local unescape
-- States: in_plain, after_backslash
local state

do
  -- Handling simple one-char substitutions like "\n"
  local FixedSubsts_Map =
    {
      ['a'] = AsciiChars.bell,
      ['b'] = AsciiChars.backspace,
      ['f'] = AsciiChars.form_feed,
      ['n'] = AsciiChars.newline,
      ['r'] = AsciiChars.carriage_return,
      ['t'] = AsciiChars.tab,
      ['v'] = AsciiChars.vertical_tab,
      [AsciiChars.double_quote] = AsciiChars.double_quote,
      [AsciiChars.single_quote] = AsciiChars.single_quote,
      [AsciiChars.newline] = AsciiChars.newline,
    }

  -- Handling "\z"
  local space_chars_seq_fmt = 'z' .. '[\000-\032]*'

  -- Handing "\10"
  local dec_code_fmt = '(%d%d?%d?)'
  local decode_dec_code =
    function(code_str)
      return str_char(str_to_int(code_str, 10))
    end

  -- Handling "\x0a"
  local hex_code_fmt = 'x' .. '(%x%x)'
  local decode_hex_code =
    function(code_str)
      return str_char(str_to_int(code_str, 16))
    end

  -- Handling "\u{2424}"
  local utf_code_fmt = 'u' .. '{' .. '(%x+)' .. '}'
  local decode_utf_code =
    function(code_str)
      return utf8_char(str_to_int(code_str, 16))
    end

  local start_of_string_fmt = '^'

  unescape =
    function(str)
      if (state == 'in_plain') then
        state = 'after_backslash'
        goto done
      end

      -- We are here after backslash

      -- Case \\
      if (str == '') then
        str = separator
        state = 'in_plain'
        goto done
      end

      do
        local fmt

        -- One-char substs: \n \t etc
        for key, val in pairs(FixedSubsts_Map) do
          fmt = start_of_string_fmt .. key
          if str_find(str, fmt) then
            str = val .. str_sub(str, 2)
            goto done
          end
        end

        -- Handling \z
        do
          fmt = start_of_string_fmt .. space_chars_seq_fmt
          local _, match_end_pos = str_find(str, fmt)
          if match_end_pos then
            str = str_sub(str, match_end_pos + 1)
            goto done
          end
        end

        -- Handling \10
        do
          fmt = start_of_string_fmt .. dec_code_fmt
          local _, match_end_pos, dec_code_str = str_find(str, fmt)
          if dec_code_str then
            str =
              decode_dec_code(dec_code_str) ..
              str_sub(str, match_end_pos + 1)
            goto done
          end
        end

        -- Handling \x0a
        do
          fmt = start_of_string_fmt .. hex_code_fmt
          local _, match_end_pos, hex_code_str = str_find(str, fmt)
          if hex_code_str then
            str =
              decode_hex_code(hex_code_str) ..
              str_sub(str, match_end_pos + 1)
            goto done
          end
        end

        -- Handling \u{2424}
        do
          fmt = start_of_string_fmt .. utf_code_fmt
          local _, match_end_pos, utf_code_str = str_find(str, fmt)
          if utf_code_str then
            str =
              decode_utf_code(utf_code_str) ..
              str_sub(str, match_end_pos + 1)
            goto done
          end
        end

        -- Something unknown after backslash
        error('Unknown escape sequence.')
      end

      :: done ::

      return str
    end
end

-- Unquote Lua string quoted in linear encoding (backslashes)
local unquote_string
do
  local str_split = request('!.string.split')
  local list_to_str = request('!.concepts.list.to_string')

  unquote_string =
    function(str)
      state = 'in_plain'

      if str_find(str, separator) then
        -- Always correct but costly
        str = str .. separator
        local Parts = str_split(str, separator)
        for index, part_str in ipairs(Parts) do
          Parts[index] = unescape(part_str)
        end
        str = list_to_str(Parts)
      else
        -- Fast
        str = unescape(str)
      end

      return str
    end
end

-- Export:
return unquote_string

--[[
  2017 # #
  2026-04 # #
  2026-08-01
  2026-08-07
  2026-08-08
]]
