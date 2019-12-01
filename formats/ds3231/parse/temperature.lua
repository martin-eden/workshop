--[[
  Parse two bytes with temperature value.

  Temperature encoded in two's complement format.
  Temperature is 10-bit value, two high bits in <frac_part>
  are two bits of fractional part.
]]

local slice_bits = request('!.number.slice_bits')

return
  function(int_part, frac_part)
    local result

    result = (int_part << 2) | slice_bits(frac_part, 6, 7)

    -- is negative value?
    if (result & 0x200 ~= 0) then
      result = -(((result & 0x1FF) ~ 0x1FF) + 1)
    end

    result = result / 4

    return result
  end
