--[[
  Parse 64-bit link to file locators.

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

local assert_signature = request('assert_signature')

local record = '< c4 I8 I2 I2 I4 I4 I8 I8 I8 I8'
local rec_size = record:packsize()

local expected_sign = 'PK\x06\x06'

return
  function(stream)
    local rec_offset = stream:get_position() - 1
    local chunk = stream:read(rec_size)

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
      locators_offset
      = record:unpack(chunk)

    assert_signature(signature, expected_sign, rec_offset)

    return
      {
        meta =
          {
            type = 'locators_link_64',
            offset = rec_offset,
          },
        structure_size = structure_size,
        version_made_by = version_made_by,
        version_to_extract = version_to_extract,
        current_disk_number = current_disk_number,
        start_disk_number = start_disk_number,
        num_entries_on_disk = num_entries_on_disk,
        num_entries = num_entries,
        directory_size = directory_size,
        offset = locators_offset,
      }
  end
