--[[
  Parse file locator.

  Official record name: "Central directory header", "File header".

  signature, 4, 'PK\x01\x02'
  version_made_by, 2
  version_to_extract, 2
  bit_flag, 2
  compression_method, 2
  file_time, 2
  file_date, 2
  crc32, 4
  compressed_size, 4
  original_size, 4
  filename_length, 2
  extra_data_length, 2
  comment_length, 2
  file_disk, 2
  internal_file_attributes, 2
  external_file_attributes, 4
  file_offset, 4
  filename, <filename_length>
  extra_data, <extra_data_length>
  comment, <comment_length>
]]

local assert_signature = request('assert_signature')
local to_bit_field = request('!.formats.bit_field.decode')
local decode_date = request('!.formats.msdos_time.decode_date')
local decode_time = request('!.formats.msdos_time.decode_time')
local parse_extra_data = request('extra_data')

local record = '< c4 I2 I2 c2 I2 c2 c2 c4 I4 I4 I2 I2 I2 I2 c2 c4 I4'
local rec_size = record:packsize()

local expected_sign = 'PK\x01\x02'

return
  function(stream)
    local rec_offset = stream:get_position() - 1
    local chunk = stream:read(rec_size)
    local
      signature,
      version_made_by,
      version_to_extract,
      bit_flag,
      compression_method,
      file_time,
      file_date,
      crc32,
      compressed_size,
      original_size,
      filename_length,
      extra_data_length,
      comment_length,
      file_disk,
      internal_file_attributes,
      external_file_attributes,
      file_offset
      = record:unpack(chunk)

    assert_signature(signature, expected_sign, rec_offset)

    local filename = stream:read(filename_length)
    local extra_data = stream:read(extra_data_length)
    local comment = stream:read(comment_length)

    bit_flag = to_bit_field(bit_flag)
    file_date = decode_date(file_date)
    file_time = decode_time(file_time)
    if (extra_data ~= '') then
      extra_data = parse_extra_data(extra_data)
    end

    return
      {
        meta =
          {
            type = 'file_locator',
            offset = rec_offset,
          },
        version_made_by = version_made_by,
        version_to_extract = version_to_extract,
        bit_flag = bit_flag,
        compression_method = compression_method,
        file_time = file_time,
        file_date = file_date,
        crc32 = crc32,
        compressed_size = compressed_size,
        original_size = original_size,
        file_disk = file_disk,
        internal_file_attributes = internal_file_attributes,
        external_file_attributes = external_file_attributes,
        file_offset = file_offset,
        filename_length = filename_length,
        filename = filename,
        extra_data_length = extra_data_length,
        extra_data = extra_data,
        comment_length = comment_length,
        comment = comment,
      }
  end
