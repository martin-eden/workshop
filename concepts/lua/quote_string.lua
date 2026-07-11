-- Decision-making function how to represent data in Lua string syntax

--[[
  Author: Martin Eden
  Last mod.: 2026-07-12
]]

--[[
  "Fixed-quote mode" is when we're using "'" or " for quoting.
  They allow fancy \-backslash codes.

  There is "variable-quote mode" (also called "intact") when
  we're using directed fancy quotes "[===[" and "]===]" with
  amount of "="'s determined in situ.
]]

-- Imports:
local QuoteChars = request('QuoteChars')
local get_chars_count = request('!.string.get_chars_count')
local ControlChars_Map = request('!.concepts.AsciiControlCodes_Map')
local intersect_set = request('!.table.intersect')
local is_empty_set = request('!.table.is_empty')
local quote_variable = request('quote_string.intact')
local quote_char_func = request('quote_string.quote_char')

local newline_code = QuoteChars.newline_code

local str_gsub = string.gsub

local has_messy_control_chars =
  function(UsedChars)
    local MessyControlChars = new(ControlChars_Map)

    -- We can handle code 10 (newline), so remove it from messy chars
    MessyControlChars[newline_code] = nil

    intersect_set(MessyControlChars, UsedChars)

    return not is_empty_set(MessyControlChars)
  end

local determine_fixed_quote_char =
  function(UsedChars)
    local single_quote_code = QuoteChars.single_quote_code
    local double_quote_code = QuoteChars.double_quote_code
    local single_quote = QuoteChars.single_quote
    local double_quote = QuoteChars.double_quote

    local num_single_quotes = UsedChars[single_quote_code] or 0
    local num_double_quotes = UsedChars[double_quote_code] or 0

    if (num_single_quotes <= num_double_quotes) then
      return single_quote
    else
      return double_quote
    end
  end

local BinaryEntitiesLengths_Map =
  {
    [1 << 0] = true,
    [1 << 1] = true,
    [1 << 2] = true,
    [1 << 3] = true,
  }

local quote_string =
  function(str)
    local single_quote_code = QuoteChars.single_quote_code
    local double_quote_code = QuoteChars.double_quote_code
    local backslash_code = QuoteChars.backslash_code
    local backslash = QuoteChars.backslash

    local UsedChars_Map = get_chars_count(str)

    local str_has_messy_control_chars =
      has_messy_control_chars(UsedChars_Map)

    local str_has_messy_printable_chars =
      UsedChars_Map[newline_code] or
      UsedChars_Map[backslash_code] or
      (
        UsedChars_Map[single_quote_code] and
        UsedChars_Map[double_quote_code]
      )

    local use_variable_quotes =
      str_has_messy_printable_chars and not str_has_messy_control_chars

    if use_variable_quotes then
      return quote_variable(str)
    else
      local quote_char = determine_fixed_quote_char(UsedChars_Map)

      local quote_all = false
      local quote_control = false

      if str_has_messy_control_chars then
        if BinaryEntitiesLengths_Map[#str] then
          quote_all = true
        else
          quote_control = true
        end
      end

      if quote_all then
        str = str_gsub(str, '.', quote_char_func)
      else
        str = str_gsub(str, backslash, backslash .. backslash)
        str = str_gsub(str, quote_char, backslash .. quote_char)

        if quote_control then
          str = str_gsub(str, '[%c]', quote_char_func)
        end
      end

      return quote_char .. str .. quote_char
    end
  end

-- Export:
return quote_string

--[[
  2016 #
  2017 #
  2024 #
  2026 #
  2026-07-11
  2026-07-12
]]
