-- Serialize table to "annotated strings" format

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

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

-- Imports:
local get_keys = request('!.table.get_keys')
local serialize_key_val = request('Compiler.SerializeKeyVal')
local add_to_list = request('!.concepts.list.add_item')
local lines_to_str = request('!.convert.lines_to_str')

local save =
  function(Data, KeysOrder)
    assert_table(Data)
    assert(is_nil(KeysOrder) or is_table(KeysOrder))

    -- When no key order is given, get all keys and sort them:
    if is_nil(KeysOrder) then
      KeysOrder = get_keys(Data)
      table.sort(KeysOrder)
    end

    local Lines = { }
    for _, key in ipairs(KeysOrder) do
      local value = Data[key]
      -- If we got <KeysOrder> from outside, there may be no value
      if value then
        add_to_list(Lines, serialize_key_val(key, value))
      end
    end

    return lines_to_str(Lines)
  end

-- Export:
return save

--[[
  2024 # # # #
  2026-05-04
]]
