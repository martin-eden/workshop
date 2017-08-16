--[[
  Implementation notes

    * Storing <original_block> may be eliminated. Just directly add that
      preknown values to <result>. Maybe I'll do this later.

    * There are two rounds in outer cycle, so for 20 rounds we need 10
      iterations.
]]

local rol = request('!.mechs.bin_ops.rol')
local shifts = {[0] = 7, [1] = 9,  [2] = 13, [3] = 18}

return
  function(self, block_num)
    local key = self.inner_key
    local salt = self.inner_salt
    local block_num_1 = block_num & 0xFFFFFFFF
    local block_num_2 = (block_num >> 32) & 0xFFFFFFFF
    local result =
      {
        0x61707865, key[1], key[2], key[3],
        key[4], 0x3320646E, salt[1], salt[2],
        block_num_1, block_num_2, 0x79622D32, key[5],
        key[6], key[7], key[8], 0x6B206574,
      }

    local orig_block = {}
    for i = 1, #result do
      orig_block[i] = result[i]
    end

    for round = 1, 10 do
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

    self:print_block(result)

    return result
  end
