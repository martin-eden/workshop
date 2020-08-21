local get_bytes_seq = request('^.md5.seq_i4_to_i1')

return
  function(self)
    local result = get_bytes_seq(self.hash[1])
    result = get_bytes_seq(self.hash[2], result)
    return result
  end
