local byte_seq_to_str = request('bytes_seq_to_str')

return
  function(self, s)
    return byte_seq_to_str(self:get_hash(s))
  end
