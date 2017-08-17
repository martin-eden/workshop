--[[
  Implementation notes

    * There are two rounds in outer cycle, so for 20 rounds we need 10
      iterations.
]]

local rol = request('!.bare.bin_ops.rol32')

return
  function(orig_block, shifts, num_dbl_rounds)
    local result = {}
    for i = 1, #orig_block do
      result[i] = orig_block[i]
    end

    for round = 1, num_dbl_rounds do
      for i = 0, 3 do
        for a = 0, 3 do
          local cur = ((a + i + 1) % 4) * 4 + a + 1
          local prev = ((a + i) % 4) * 4 + a + 1
          local prev_prev = ((a + i + 3) % 4) * 4 + a + 1
          result[cur] =
            result[cur] ~ rol(result[prev] + result[prev_prev], shifts[i])
        end
      end
      for i = 0, 3 do
        for a = 0, 3 do
          local cur = a * 4 + ((a + i + 1) % 4) + 1
          local prev = a * 4 + ((a + i) % 4) + 1
          local prev_prev = a * 4 + ((a + i + 3) % 4) + 1
          result[cur] =
            result[cur] ~ rol(result[prev] + result[prev_prev], shifts[i])
        end
      end
    end

    for i = 1, #result do
      result[i] = (result[i] + orig_block[i]) & 0xFFFFFFFF
    end

    return result
  end
