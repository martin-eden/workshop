-- Parse color component value

-- Last mod.: 2024-11-06

-- Imports:
local NumberInRange = request('!.number.in_range')

--[[
  Parse color component value from string to integer.

  Checks that integer is within max color component range.

  In case of problems returns nil.
]]
local ParseColorComponent =
  function(self, Value)
    local MaxColorValue = self.Constants.MaxColorValue

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
]]
