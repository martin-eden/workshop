--[[
  Parse string with zip64 extra data chunk. Return table.

  According ".ZIP File Format Specification" (v6.3.4, 2014-10-01)
  states there may be

    [original_size, 8]
    [compressed_size, 8]
    [file_offset, 8]
    [file_disk, 4]

  Field is present only where it's lower-bit integer can't
  represent value.

  Order of fields which present is same: original_size,
  compressed_size, offset, disk_num.

  But for "local file header" there must be both original and
  compressed file size fields if one of these values is over uint4.

  Actual parsing of returned structure is done in [name_zip64_fields].
]]

return
  function(data)
    local start_pos = 1
    local value
    local result = {}
    while (start_pos <= #data) do
      if (#data - start_pos + 1 == 4) then
        value, start_pos = ('< I4'):unpack(data, start_pos)
      else
        value, start_pos = ('< I8'):unpack(data, start_pos)
      end
      table.insert(result, value)
    end
    return result
  end
