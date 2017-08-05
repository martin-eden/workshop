local unpack_chunk = request('^.md5.unpack_chunk')

return
  function(self, s, read_pos)
    local data = unpack_chunk(s, read_pos)

    self.hash_operation(
      self.hash[1],
      self.funcs,
      self.msg_map,
      data,
      self.salt[1],
      self.shifts
    )
    self.hash_operation(
      self.hash[2],
      self.funcs,
      self.msg_map,
      data,
      self.salt[2],
      self.shifts
    )
    self.hash[1][1], self.hash[2][1] = self.hash[2][1], self.hash[1][1]
  end
