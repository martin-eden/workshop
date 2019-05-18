--[[
  0xF0 (sysex_start)
  0x77 (i2c_reply)
  <= 0x7F (device_id & 0x7F)
  <= 1 (device_id >> 7)
  <= 0x7F (offset & 0x7F)
  <= 1 (offset >> 7)
  <= 0x7F (data[1] & 0x7F)
  <= 1 (data[1] >> 7)
  ...
  0xF7 (sysex_stop)
]]

local type_name = 'i2c_reply'

local frame_sysex = request('^.implementation.frame_sysex')
local to_byte = request('^.implementation.to_byte')
local to_bytes = request('^.implementation.to_bytes')

local signature =
  request('!.formats.firmata.protocol.signatures').i2c_reply

return
  function(stream)
    local chunk = frame_sysex(stream)
    if not chunk then
      return
    end

    local
      header,
      device_id_0, device_id_1,
      offset_0, offset_1,
      read_pos = ('B BB BB'):unpack(chunk)

    if (header ~= signature) then
      return
    end

    local device_id = to_byte(device_id_0, device_id_1)
    local offset = to_byte(offset_0, offset_1)
    local data = to_bytes(chunk:sub(read_pos))

    local result =
      {
        type = type_name,
        device_id = device_id,
        offset = offset,
        data = data,
      }
     return result
  end
