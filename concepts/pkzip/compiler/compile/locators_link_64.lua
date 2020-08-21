--[[
  Compile 64-bit link to file locators.

  Official record name: "Zip64 end of central directory record".

  signature, 4, 'PK\x06\x06'
  structure_size, 8
  version_made_by, 2
  version_to_extract, 2
  current_disk_number, 4
  start_disk_number, 4
  num_entries_on_disk, 8
  num_entries, 8
  directory_size, 8
  locators_offset, 8
]]

local record = '< c4 I8 I2 I2 I4 I4 I8 I8 I8 I8'

return
  function(rec, stream)
    stream:set_position(rec.meta.offset + 1)

    local chunk =
      record:pack(
        'PK\x06\x06',
        rec.structure_size,
        rec.version_made_by,
        rec.version_to_extract,
        rec.current_disk_number,
        rec.start_disk_number,
        rec.num_entries_on_disk,
        rec.num_entries,
        rec.directory_size,
        rec.offset
      )

    stream:write(chunk)
  end
