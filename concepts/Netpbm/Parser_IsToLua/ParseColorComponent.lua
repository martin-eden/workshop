-- Parse color component value

-- Last mod.: 2025-03-29

-- Imports:
local NumberInRange = request('!.number.in_range')
local MaxColorValue = request('^.Settings.Interface').MaxColorValue

--[[
  Parse color component value from string to integer.

  Checks that integer is within max color component range.

  In case of problems returns nil.
]]
local ParseColorComponent =
  function(self, Value)
    Value = tonumber(Value)

    if not is_integer(Value) then
      return
    end

    if not NumberInRange(Value, 0, MaxColorValue) then
      return
    end

    return Value
  end

-- Exports:
return ParseColorComponent

--[[
  2024-11-03
  2025-03-28
]]
