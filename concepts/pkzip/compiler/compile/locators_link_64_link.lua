--[[
  Compile link to 64-bit link to list of file locators.

  Official record name: "Zip64 end of central directory locator".

  signature, 4, 'PK\x06\x07'
  start_disk_number, 4
  locators_link_offset, 8
  num_disks, 4
]]

local record = '< c4 I4 I8 I4'

return
  function(rec, stream)
    stream:set_position(rec.meta.offset + 1)

    local chunk =
      record:pack(
        'PK\x06\x07',
        rec.start_disk_number,
        rec.offset,
        rec.num_disks
      )

    stream:write(chunk)
  end
