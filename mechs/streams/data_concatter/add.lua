return
  function(self, chunk)
    assert_string(chunk)
    local stream = self.stream
    local s = stream:read(stream:get_length())
    s = s .. chunk
    stream:init(s)
  end
