local get_bytes_seq = request('seq_i4_to_i1')

return
  function(self)
    return get_bytes_seq(self.hash)
  end
