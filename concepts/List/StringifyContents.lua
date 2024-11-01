-- Convert list contents to strings. Accepts folded lists

-- Last mod.: 2024-11-01

local Stringify =
  function(List)
    for Index, Value in ipairs(List) do
      if is_table(Value) then
        Stringify(Value)
      elseif not is_string(Value) then
        List[Index] = tostring(Value)
      end
    end
  end

-- Exports:
return Stringify

--[[
  2024-11-01
]]
