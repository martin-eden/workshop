-- Parse line to key-value. Annotated lines format.

--[[
  Input

    string

  Output

    (string, string)

  Notes

    Mind the spaces:

      ParseLine('a = A == B') -> {'a ', ' A == a'}
]]

--[[
  Version: 2
  Last mod.: 2024-02-28
]]

local ParsePattern = '(.-)=(.+)'

return
  function(Line)
    assert_string(Line)

    local Key, Value

    Key, Value = string.match(Line, ParsePattern)

    return Key, Value
  end

--[[
  2024-02-15
  2024-02-28
]]
