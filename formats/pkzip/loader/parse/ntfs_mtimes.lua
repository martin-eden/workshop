return
  function(self, data)
    local modified, accessed, created  = ('< c8 c8 c8'):unpack(data)
    return
      {
        created = created,
        modified = modified,
        accessed = accessed,
      }
  end
