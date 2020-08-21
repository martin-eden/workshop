--[[
  Parse link to 64-bit link to list of links to files.

  Am I said this is great file format?

  Official record name: "Zip64 end of central directory locator".

  signature, 4, 'PK\x06\x07'
  start_disk_number, 4
  locators_link_offset, 8
  num_disks, 4
]]

local assert_signature = request('assert_signature')

local record = '< c4 I4 I8 I4'
local rec_size = record:packsize()

local expected_sign = 'PK\x06\x07'

return
  function(stream)
    local rec_offset = stream:get_position() - 1
    local chunk = stream:read(rec_size)

    local
      signature,
      start_disk_number,
      locators_link_offset,
      num_disks
      = record:unpack(chunk)

    assert_signature(signature, expected_sign, rec_offset)

    return
      {
        meta =
          {
            type = 'locators_link_64_link',
            offset = rec_offset,
          },
        start_disk_number = start_disk_number,
        offset = locators_link_offset,
        num_disks = num_disks,
      }
  end
