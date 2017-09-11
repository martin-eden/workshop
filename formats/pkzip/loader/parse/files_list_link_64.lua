--[[
  signature, 4, 'PK\x06\x06'
  structure_size, 8
  version_made_by, 2
  version_to_extract, 2
  current_disk_number, 4
  start_disk_number, 4
  num_entries_on_disk, 8
  num_entries, 8
  directory_size, 8
  files_list_offset, 8
]]

local format = '< c4 I8 I2 I2 I4 I4 I8 I8 I8 I8'

return
  function(self)
    local chunk = self.in_stream:read(format:packsize())

    local results = {format:unpack(chunk)}
    results[#results] = nil

    local
      signature,
      structure_size,
      version_made_by,
      version_to_extract,
      current_disk_number,
      start_disk_number,
      num_entries_on_disk,
      num_entries,
      directory_size,
      files_list_offset =
      table.unpack(results)

    assert(signature == self.signatures.files_list_link_64, 'Signature mismatch.')

    return
      {
        signature = signature,
        structure_size = structure_size,
        version_made_by = version_made_by,
        version_to_extract = version_to_extract,
        current_disk_number = current_disk_number,
        start_disk_number = start_disk_number,
        num_entries_on_disk = num_entries_on_disk,
        num_entries = num_entries,
        directory_size = directory_size,
        files_list_offset = files_list_offset,
      }
  end
