--[[
  Parse link to file locators.

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

local assert_signature = request('assert_signature')

local record = '< c4 I2 I2 I2 I2 I4 I4 I2'
local rec_size = record:packsize()

local expected_sign = 'PK\x05\x06'

return
  function(stream)
    local rec_offset = stream:get_position() - 1
    local chunk = stream:read(rec_size)

    local
      signature,
      this_disk_number,
      start_disk_number,
      num_entries_on_disk,
      num_entries,
      directory_size,
      locators_offset,
      comment_length
      = record:unpack(chunk)

    assert_signature(signature, expected_sign, rec_offset)

    local comment = stream:read(comment_length)

    return
      {
        meta =
          {
            type = 'locators_link',
            offset = rec_offset,
          },
        this_disk_number = this_disk_number,
        start_disk_number = start_disk_number,
        num_entries_on_disk = num_entries_on_disk,
        num_entries = num_entries,
        directory_size = directory_size,
        offset = locators_offset,
        comment_length = comment_length,
        comment = comment,
      }
  end
