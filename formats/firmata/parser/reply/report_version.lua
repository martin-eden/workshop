local type_name = 'report_version'

local frame_sysex = request('^.implementation.frame_sysex')
local to_8bit_string = request('^.implementation.to_8bit_string')

local signature =
  request('!.formats.firmata.protocol.signatures').firmware

return
  function(stream)
    local chunk = frame_sysex(stream)

    if not chunk then
      return
    end

    local
      header,
      major,
      minor,
      read_pos =
      ('BBB'):unpack(chunk)

    local is_valid =
      (header == signature) and
      (major <= 0x7F) and
      (minor <= 0x7F)

    if not is_valid then
      return
    end

    chunk = chunk:sub(read_pos)
    local file_name = to_8bit_string(chunk)

    local result =
      {
        type = type_name,
        major = major,
        minor = minor,
        file_name = file_name,
      }

    return result
  end
