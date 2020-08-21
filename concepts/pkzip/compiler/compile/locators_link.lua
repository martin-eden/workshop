--[[
  Compile link to file locators.

  Official record name: "End of central directory record".

  signature, 4, 'PK\x05\x06'
  this_disk_number, 2
  start_disk_number, 2
  num_entries_on_disk, 2
  num_entries, 2
  directory_size, 4
  locators_offset, 4
  comment_length, 2
  comment, <comment_length>
]]

local record = '< c4 I2 I2 I2 I2 I4 I4 I2'

return
  function(rec, stream)
    stream:set_position(rec.meta.offset + 1)

    local chunk =
      record:pack(
        'PK\x05\x06',
        rec.this_disk_number,
        rec.start_disk_number,
        rec.num_entries_on_disk,
        rec.num_entries,
        rec.directory_size,
        rec.offset,
        rec.comment_length
      )
    stream:write(chunk)

    stream:write(rec.comment)
  end
