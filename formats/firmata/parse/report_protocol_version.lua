local type_name = 'report_protocol_version'

local record = 'B B B'
local rec_size = record:packsize()

local signature = request('^.protocol.signatures').protocol_version

return
  function(stream)
    local chunk = stream:block_read(rec_size)

    if not chunk then
      return
    end

    local
      header,
      major,
      minor =
      record:unpack(chunk)

    local is_valid =
      (header == signature) and
      (major <= 0x7F) and
      (minor <= 0x7F)

    if not is_valid then
      return
    end

    local result =
      {
        type = type_name,
        major = major,
        minor = minor,
      }

    return result
  end
