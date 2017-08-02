local unpack_chunk = request('^.md5.unpack_chunk')

return
  function(self, s, read_pos)
    local data = unpack_chunk(s, read_pos)

    self.hash_operation(
      self.hash,
      self.funcs,
      self.msg_map,
      data,
      self.salt,
      self.shifts
    )
  end
