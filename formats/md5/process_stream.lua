return
  function(self, s)
    assert_string(s)
    local data_length = #s
    local read_pos = 1
    while (data_length - read_pos + 1 >= 64) do
      self:process_block(s, read_pos)
      read_pos = read_pos + 64
    end
    local last_chunk = s:sub(read_pos) .. '\x80'
    local length_chunk = ('<I8'):pack(data_length * 8)
    if (#last_chunk > 56) then
      last_chunk = last_chunk .. ('\x00'):rep(64 - #last_chunk)
      self:process_block(last_chunk)
      last_chunk = ''
    end
    if (#last_chunk <= 56) then
      last_chunk = last_chunk .. ('\x00'):rep(56 - #last_chunk) .. length_chunk
      self:process_block(last_chunk)
    end
  end
