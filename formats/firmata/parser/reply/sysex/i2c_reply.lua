--[[
  <= 0x7F (device_id & 0x7F)
  <= 1 (device_id >> 7)
  <= 0x7F (offset & 0x7F)
  <= 1 (offset >> 7)
  <= 0x7F (data[1] & 0x7F)
  <= 1 (data[1] >> 7)
  ...
]]

return
  function(self, chunk)
    local device_id = self:to_word(chunk:byte(1, 2))
    local offset = self:to_word(chunk:byte(3, 4))
    local data = self:to_bytes(chunk:sub(5))

    local aligned_data = {}
    table.move(data, 1, #data, offset, aligned_data)
    data = aligned_data

    return
      {
        device_id = device_id,
        offset = offset,
        data = data,
      }
  end
