--[[
  signature, 'PK\x06\x07'
  start_disk_number, 4
  directory_end_i64_offs, 8
  num_disks, 4
]]

local format = '< c4 I4 I8 I4'

return
  function(self)
    local chunk = self.in_stream:read(format:packsize())

    local results = {format:unpack(chunk)}
    results[#results] = nil

    local
      signature,
      start_disk_number,
      next_rec_offset,
      num_disks =
      table.unpack(results)

    return
      {
        signature = signature,
        start_disk_number = start_disk_number,
        next_rec_offset = next_rec_offset,
        num_disks = num_disks,
      }
  end
