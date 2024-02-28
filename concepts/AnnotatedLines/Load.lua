-- Parse annotated lines

--[[
  Input

    string

      Annotated lines. Usually contents of file.

  Output

    table

      Parsed contents in table indexed by key names.

  Special case

    If there are duplicate keys in output

      We're keeping the last value

  Example

    Load('a=1'.. '\n' .. 'b=2' .. '\n' .. 'a=3') ->
      { ['a'] = '3', ['b'] = '2' }
]]

-- Last mod.: 2024-02-28

local IterateLines = request('!.string.lines')
local ParseLine = request('Parser.ParseLine')

return
  function(DataString)
    assert_string(DataString)

    local Result = {}

    for _, Line in IterateLines(DataString) do
      local Key, Value = ParseLine(Line)

      assert_string(Key)
      assert_string(Value)
      Result[Key] = Value
    end

    return Result
  end

--[[
  2028-02-15
  2025-02-28
]]
