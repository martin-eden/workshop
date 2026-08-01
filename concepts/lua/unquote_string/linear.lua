-- Unquote Lua string that is quoted with backslashes

--[[
  Author: Martin Eden
  Last mod.: 2026-08-01
]]

-- Imports:
local Ascii = request('!.concepts.Ascii')

local str_to_int = tonumber
local str_char = string.char
local utf8_char = utf8.char
local str_gsub = string.gsub

local unescape
do
  local one_char_seq_subst =
    {
      [ [[\a]] ] = Ascii.Chars.bell,
      [ [[\b]] ] = Ascii.Chars.backspace,
      [ [[\f]] ] = Ascii.Chars.form_feed,
      [ [[\n]] ] = Ascii.Chars.newline,
      [ [[\r]] ] = Ascii.Chars.carriage_return,
      [ [[\t]] ] = Ascii.Chars.tab,
      [ [[\v]] ] = Ascii.Chars.vertical_tab,
      [ [[\"]] ] = Ascii.Chars.double_quote,
      [ [[\']] ] = Ascii.Chars.single_quote,
      [ [[\]] .. Ascii.Chars.newline] = Ascii.Chars.newline,
    }

  local space_chars_seq = [[\z[\000-\032]*]]

  local dec_code_seq = [[\(%d%d?%d?)]]
  local decode_dec_code =
    function(code_str)
      return str_char(str_to_int(code_str, 10))
    end

  local hex_code_seq = [[\x(%x%x)]]
  local decode_hex_code =
    function(code_str)
      return str_char(str_to_int(code_str, 16))
    end

  local utf_code_seq = [[\u{(%x+)}]]
  local decode_utf_code =
    function(code_str)
      return utf8_char(str_to_int(code_str, 16))
    end

  unescape =
    function(str)
      str = str_gsub(str, [[\.]], one_char_seq_subst)
      str = str_gsub(str, space_chars_seq, '')
      str = str_gsub(str, dec_code_seq, decode_dec_code)
      str = str_gsub(str, hex_code_seq, decode_hex_code)
      str = str_gsub(str, utf_code_seq, decode_utf_code)

      return str
    end
end

-- Unquote Lua string quoted in linear encoding (backslashes)
local unquote_string
do
  local backslash = Ascii.Chars.backslash
  local double_backslash = backslash .. backslash

  local str_find = string.find
  local str_split = request('!.string.split')
  local list_to_str = request('!.concepts.list.to_string')

  unquote_string =
    function(str)
      if str_find(str, double_backslash) then
        -- Always correct
        local Parts = str_split(str, double_backslash)
        for index, part_str in ipairs(Parts) do
          Parts[index] = unescape(part_str)
        end
        str = list_to_str(Parts, backslash)
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
]]
