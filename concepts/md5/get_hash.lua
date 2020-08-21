return
  function(self, s)
    self:process_stream(s)
    return self:get_hash_seq()
  end
