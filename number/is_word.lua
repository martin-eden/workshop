-- Check that given argument is integer in 16-bit word range

--[[
  Input

    Value: any - any value

  Output

    Yes: bool - value is integer in 16-bit word range ([0, 0xFFFF]).
]]

return
  function(Value)
    if not is_integer(Value) then
      return false
    end

    -- Masking integer with word changes nothing for word range
    local Result = (Value == (Value & 0xFFFF))

    return Result
  end

--[[
  2024-09-30
]]
