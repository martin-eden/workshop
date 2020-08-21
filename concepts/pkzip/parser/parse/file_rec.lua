--[[
  Parse file record.

  Actual compressed file contents is not retrieved here. That's
  because actual <compressed_size> may be stored in int64 in
  <extra_data>. Or in <locator> and in <post_rec>. That things are
  determined and handled at [process_files].

  Official record name: "Local file header".

  signature, 4, 'PK\x03\x04'
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
  filename, <filename_length>
  extra_data, <extra_data_length>
  data, <compressed_size>
]]

local assert_signature = request('assert_signature')
local to_bit_field = request('!.concepts.bit_field.decode')
local decode_date = request('!.concepts.msdos_time.decode_date')
local decode_time = request('!.concepts.msdos_time.decode_time')
local parse_extra_data = request('extra_data')

local record = '< c4 I2 c2 I2 c2 c2 c4 I4 I4 I2 I2'
local rec_size = record:packsize()

local expected_sign = 'PK\x03\x04'

return
  function(stream)
    local rec_offset = stream:get_position() - 1
    local chunk = stream:read(rec_size)

    local
      signature,
      version_to_extract,
      bit_flag,
      compression_method,
      file_time,
      file_date,
      crc32,
      compressed_size,
      original_size,
      filename_length,
      extra_data_length
      = record:unpack(chunk)

    assert_signature(signature, expected_sign, rec_offset)

    local filename = stream:read(filename_length)
    local extra_data = stream:read(extra_data_length)

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
            type = 'file_prefix',
            offset = rec_offset,
          },
        version_to_extract = version_to_extract,
        bit_flag = bit_flag,
        compression_method = compression_method,
        file_time = file_time,
        file_date = file_date,
        crc32 = crc32,
        compressed_size = compressed_size,
        original_size = original_size,
        filename_length = filename_length,
        filename = filename,
        extra_data_length = extra_data_length,
        extra_data = extra_data,
      }
  end
