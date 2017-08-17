local unpack_chunk = request('unpack_chunk')
local rol = request('!.bare.bin_ops.rol32')

return
  function(self, s, read_pos)
    local data = unpack_chunk(s, read_pos)

    local h1, h2, h3, h4 = self.hash[1], self.hash[2], self.hash[3], self.hash[4]
    local salt = self.salt

    for round = 1, 4 do
      local mix = self.funcs[round]
      local map = self.msg_map[round]
      local shifts = self.shifts[round]
      for i = 1, 16 do
        local slot_val =
          (
            rol(
              h1 + mix(h2, h3, h4) + data[map[i]] + salt[(round - 1) * 16 + i],
              shifts[(i - 1) % 4 + 1]
            ) + h2
          ) & 0xffffffff
        h1, h2, h3, h4 = h4, slot_val, h2, h3
      end
    end

    self.hash[1] = (self.hash[1] + h1) & 0xffffffff
    self.hash[2] = (self.hash[2] + h2) & 0xffffffff
    self.hash[3] = (self.hash[3] + h3) & 0xffffffff
    self.hash[4] = (self.hash[4] + h4) & 0xffffffff
  end
