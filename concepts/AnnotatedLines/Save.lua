-- Serialize table to "annotated strings" format

--[[
  Input

    table - <Data>

      Table with string keys and string values.

    [table] - <KeysOrder>

      Optional table sequence with string values.
      Each such value expected to be a key name for <Data>.
      We serialize <Data> according to order of this sequence.

      If <KeysOrder> is not present
        We create it as list of all keys in <Data>

  Output

    string

  In case of problems with input data, we just throw error().
  It's outer code responsibility to provide us with valid input.
]]

-- Last mod.: 2024-03-03

local GetKeys = request('!.table.get_keys')
local CompareKeys = request('!.table.ordered_pass.default_comparator')
local SerializeKeyVal = request('Compiler.SerializeKeyVal')
local LinesToString = request('!.string.from_lines')

return
  function(Data, KeysOrder)
    assert_table(Data)

    -- When no key order is given, get all keys and sort them:
    if is_nil(KeysOrder) then
      KeysOrder = GetKeys(Data)
      table.sort(KeysOrder, CompareKeys)
    end
    assert_table(KeysOrder)

    local Lines
    do
      Lines = {}
      for _, Key in ipairs(KeysOrder) do
        local Value = Data[Key]
        local Line = SerializeKeyVal(Key, Value)
        table.insert(Lines, Line)
      end
    end
    assert_table(Lines)

    local Result
    do
      Result = LinesToString(Lines)
    end
    assert_string(Result)

    return Result
  end

--[[
  2024-02-13
  2024-02-25
  2024-02-28
  2024-03-03
]]
