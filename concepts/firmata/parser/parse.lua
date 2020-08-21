local assert_stream = request('!.mechs.streams.assert_is_stream')

local parse =
  function(self, mode)
    assert_stream(self.stream)

    local is_request = false

    if mode then
      assert_table(mode)
      is_request = mode.is_request
    end

    local result = {}
    while self:parse_chunk(is_request, result) do
    end
    local stream_pos = self.stream:get_position()
    local stream_length = self.stream:get_length()
    local is_fully_parsed = (stream_pos - 1 == stream_length)
    local status =
      {
        stream_pos = stream_pos,
        stream_length = stream_length,
        is_fully_parsed = is_fully_parsed,
      }
    return result, status
  end

return parse
