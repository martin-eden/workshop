--[[
  Compile file locator.

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

local from_bit_field = request('!.concepts.bit_field.encode')
local encode_date = request('!.concepts.msdos_time.encode_date')
local encode_time = request('!.concepts.msdos_time.encode_time')
local compile_extra_data = request('extra_data')

local record = '< c4 I2 I2 c2 I2 c2 c2 c4 I4 I4 I2 I2 I2 I2 c2 c4 I4'

return
  function(rec, stream)
    stream:set_position(rec.meta.offset + 1)

    local chunk =
      record:pack(
        'PK\x01\x02',
        rec.version_made_by,
        rec.version_to_extract,
        from_bit_field(rec.bit_flag),
        rec.compression_method,
        encode_time(rec.file_time),
        encode_date(rec.file_date),
        rec.crc32,
        rec.compressed_size,
        rec.original_size,
        rec.filename_length,
        rec.extra_data_length,
        rec.comment_length,
        rec.file_disk,
        rec.internal_file_attributes,
        rec.external_file_attributes,
        rec.file_offset
      )
    stream:write(chunk)

    stream:write(rec.filename)

    if (rec.extra_data_length ~= 0) then
      local extra_data_raw = compile_extra_data(rec.extra_data)
      stream:write(extra_data_raw)
    end

    stream:write(rec.comment)
  end
