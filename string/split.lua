-- Split string into pieces

--[[
  Author: Martin Eden
  Last mod.: 2026-04-24
]]

-- Imports:
local quote_regexp = request('!.lua.regexp.quote')
local ends_with = request('!.string.ends_with')

--[[
  Split delimited string into list

  ( 'a/b' '/' ) -> ( 'a' 'b' )
  ( 'a/' '/' ) -> ( 'a' )

  String is always treated as it ends on delimiter.

  Cases/examples:

    ('', '') ->  ( '' )
    ('a', '') ->  ( 'a' )
    ('a', '/') -> ( 'a' )
    ('/', '/') ->  ( '' )
    ('//', '/') -> ( '' '' )
]]
local split_string =
  function(str, delimiter)
    assert_string(str)
    assert_string(delimiter)

    -- Special case: empty delimiter
    if (delimiter == '') then
      -- Return list with source string
      return { str }
    end

    if not ends_with(str, delimiter) then
      str = str .. delimiter
    end

    local Result = {}

    local item_capture = '(.-)' .. quote_regexp(delimiter) .. '()'

    local start_pos
    local end_pos
    local item_str

    start_pos = 1

    while true do
      start_pos, end_pos, item_str =
        string.find(str, item_capture, start_pos)

      if not start_pos then break end

      table.insert(Result, item_str)

      start_pos = end_pos + 1
    end

    return Result
  end

-- Export:
return split_string

--[[
  2016 # #
  2026-04-22
  2026-04-24
]]
