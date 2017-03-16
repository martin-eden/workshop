return
  function(in_stream, length)
    local raw_bytes = in_stream:block_read(length)
    if raw_bytes then
      local result
      result = ('<I' .. tostring(length)):unpack(raw_bytes)
      return result
    end
  end
