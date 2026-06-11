-- Encode string to shell

--[[
  Author: Martin Eden
  Last mod.: 2026-06-09
]]

--[[
  Examples

    -> ''
    ' -> \'
    a# -> a#
    #a -> '#a'
    a b -> 'a b'
]]

-- Imports:
local list_to_str = request('!.concepts.list.to_string')
local split_string = request('!.string.split')
local add_to_list = request('!.concepts.list.add_item')

local special_chars_regexp
local starts_with_comment_regexp
do
  -- Imports:
  local quote_regexp = request('!.lua.regexp.quote')

  do
    -- Imports:
    local SpecialChars = request('quote.SpecialChars')

    local special_chars_str = list_to_str(SpecialChars)

    special_chars_regexp = '[' .. quote_regexp(special_chars_str) .. ']'
  end

  do
    -- Imports:
    local SpaceChars = request('quote.SpaceChars')

    local space_chars_str = list_to_str(SpaceChars)

    local space_chars_regexp = '[' .. quote_regexp(space_chars_str) .. ']'

    local comment_char = '#'

    starts_with_comment_regexp = '^' .. space_chars_regexp .. '+' .. comment_char
  end
end

local needs_quoting =
  function(str)
    return
      (str == '') or
      not is_nil(string.find(str, special_chars_regexp)) or
      not is_nil(string.find(str, starts_with_comment_regexp))
  end

local quote
quote =
  function(str)
    --[[
      We're quoting only when it's needed

      F.e. "a;b" is quoted. But "a=b" is not.


      We're using single-quotes

      Happy case is when string does not contain "'".
      Then we just surround string with "'".

      If string contains "'" we split it by "'",
      quote parts, and glue with escaped "'".


      "'" can be represented as [\'] or as ["'"] or as [\039] or as ...

      We'll use [\'].
    ]]

    assert_string(str)

    if not needs_quoting(str) then return str end

    local single_quote = "'"

    if not string.find(str, single_quote) then
      return single_quote .. str .. single_quote
    end

    str = str .. single_quote

    local RawItems = split_string(str, single_quote)
    local Items = { }

    for _, item in ipairs(RawItems) do
      local quoted_item
      if (item == '') then
        -- Empty string is part here. No need to quote it
        quoted_item = ''
      else
        quoted_item = quote(item)
      end

      add_to_list(Items, quoted_item)
    end

    return list_to_str(Items, [[\]] .. single_quote)
  end

return quote

--[[
  2026-01-12
  2026-06-09
]]
