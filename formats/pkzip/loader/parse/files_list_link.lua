--[[
  signature, 4, 'PK\x05\x06'
  current_disk_number, 2
  start_disk_number, 2
  num_entries_on_disk, 2
  num_entries, 2
  directory_size, 4
  files_list_offset, 4
  comment_length, 2
  comment, <comment_length>
]]

local format = '< c4 I2 I2 I2 I2 I4 I4 I2'

return
  function(self)
    local chunk = self.in_stream:read(format:packsize())

    local results = {format:unpack(chunk)}
    results[#results] = nil

    local
      signature,
      current_disk_number,
      start_disk_number,
      num_entries_on_disk,
      num_entries,
      directory_size,
      files_list_offset,
      comment_length =
      table.unpack(results)

    local comment = self.in_stream:read(comment_length)

    return
      {
        signature = signature,
        current_disk_number = current_disk_number,
        start_disk_number = start_disk_number,
        num_entries_on_disk = num_entries_on_disk,
        num_entries = num_entries,
        directory_size = directory_size,
        files_list_offset = files_list_offset,
        comment_length = comment_length,
        comment = comment,
      }
  end
