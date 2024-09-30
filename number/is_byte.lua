-- Check that given argument is integer in byte range

--[[
  Input

    Value: any - any value

  Output

    Yes: bool - value is integer in byte range
]]

return
  function(Value)
    if not is_integer(Value) then
      return false
    end

    -- Masking integer with low byte changes nothing for byte range
    local Result = (Value == (Value & 0xFF))

    return Result
  end

--[[
  2020-08-09
  2024-09-30
]]
