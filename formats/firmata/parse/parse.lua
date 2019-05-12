local assert_stream = request('!.mechs.streams.assert_is_stream')
local parsers = request('parsers')
local parse_chunk = request('parse_chunk')

local parse =
  function(stream)
    assert_stream(stream)
    local result = {}
    while parse_chunk(stream, parsers, result) do
    end
    local stream_pos = stream:get_position()
    local stream_length = stream:get_length()
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
