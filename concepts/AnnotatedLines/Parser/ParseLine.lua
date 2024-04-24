-- Parse line to key-value. Annotated lines format.

--[[
  Input

    string

  Output

    (string, string) or
    (nil, nil)

  Notes

    Mind the spaces:

      ParseLine('a = A == B') -> {'a ', ' A == B'}

    If we can't parse string to key-value
      Return nils
      // We're not throwing error because caller can't verify data
      // without parsing. And parsing is our job.
]]

-- Last mod.: 2024-03-03

local ParsePattern = '(.-)=(.*)'

return
  function(Line)
    assert_string(Line)

    local Key, Value
    do
      Key, Value = string.match(Line, ParsePattern)
      if not (is_string(Key) and is_string(Value)) then
        return nil, nil
      end
    end
    assert_string(Key)
    assert_string(Value)

    return Key, Value
  end

--[[
  2024-02-15
  2024-02-28
  2024-03-03
]]
