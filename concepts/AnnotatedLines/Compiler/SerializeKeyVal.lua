-- Serialize key-value pair. Annotated lines format.

--[[
  Input

    string -- Key
      No newlines, no "=".

    string -- Value
      No newlines.

  Output

    string

  Throws error() if we got bad input.
]]

-- Last mod.: 2024-03-03

local AssertNoNewlines = request('!.string.assert_no_newlines')
local AssertNotContains = request('!.string.assert_not_contains')

return
  function(Key, Value)
    assert_string(Key)
    AssertNoNewlines(Key)
    AssertNotContains(Key, '=')

    assert_string(Value)
    AssertNoNewlines(Value)

    local FormatStr = "%s=%s"
    local Result = string.format(FormatStr, Key, Value)

    return Result
  end

--[[
  2024-02-13
  2024-02-25
  2024-02-28
]]
