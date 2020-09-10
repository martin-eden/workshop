--[[
  Parse raw integer with temperature value.

  Raw value is signed 10-bit integer. Two's complement encoding
  for negative values. Granularity is 0.25.
]]

local slice_bits = request('!.number.slice_bits')

return
  function(raw_value)
    local result

    result = raw_value

    -- is negative raw value?
    if (result & 0x200 ~= 0) then
      result = -(((result & 0x1FF) ~ 0x1FF) + 1)
    end

    result = result / 4

    return result
  end
