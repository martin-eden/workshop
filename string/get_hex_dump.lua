return
  function(raw_bytes)
    return
      (raw_bytes:gsub('.', function(s) return ('%02x '):format(s:byte()) end))
  end
