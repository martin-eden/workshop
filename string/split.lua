-- Split string into pieces

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

-- Imports:
local quote_regexp = request('!.lua.regexp.quote')

--[[
  Split delimited string into list

  String is treated as pairs of ( item delimiter).
  So if string not ends on delimiter (called "terminator")
  then that chunk is lost.

  Cases/examples:

    ('', '') ->  ( '' )
    ('a', '') ->  ( 'a' )
    ('/', '/') ->  ( '' )
    ('//', '/') -> ( '' '' )
    ('a//', '/') -> ( 'a' '' )
    ('/a/', '/') -> ( '' 'a' )
    ('a', '/') -> ( '' )
    ('a/', '/') -> ( 'a' )
    ('a/b', '/') -> ( 'a' )
]]
local split_string =
  function(str, terminator)
    assert_string(str)
    assert_string(terminator)

    -- Special case: empty terminator
    if (terminator == '') then
      -- Return list with source string
      return { str }
    end

    local Result = {}

    local item_capture = '(.-)' .. quote_regexp(terminator) .. '()'

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
]]
