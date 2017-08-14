--[[
  Parse string with zip64 additional data chunk. Return table.

  According ".ZIP File Format Specification" (v6.3.4, 2014-10-01)
  states there may be

    [<8_original_size>]
    [<8_compressed_size>]
    [<8_file_offset>]
    [<4_file_disk>]

  Field is present only where it's lower-bit counterpart can't
  represent value. Ordering is always same.

  (For "local file header" there must be both original and compressed
  file size fields.)

  Order of fields to check for enclusion here is same:
  original_size, compressed_size, offset, disk_num.

  Actual parsing of returned structure is done in [fill_zip64].
]]

return
  function(self, data)
    local start_pos = 1
    local n
    local result = {}
    while (start_pos <= #data) do
      n, start_pos = ('< I8'):unpack(data, start_pos)
      result[#result + 1] = n
    end
    return result
  end
