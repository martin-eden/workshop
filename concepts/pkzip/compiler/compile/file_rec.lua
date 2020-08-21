--[[
  Compile file record.

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

local from_bit_field = request('!.concepts.bit_field.encode')
local encode_date = request('!.concepts.msdos_time.encode_date')
local encode_time = request('!.concepts.msdos_time.encode_time')
local compile_extra_data = request('extra_data')
local compile_post_file_rec = request('post_file_rec')

local record = '< c4 I2 c2 I2 c2 c2 c4 I4 I4 I2 I2'

return
  function(rec, stream)
    local chunk =
      record:pack(
        'PK\x03\x04',
        rec.version_to_extract,
        from_bit_field(rec.bit_flag),
        rec.compression_method,
        encode_time(rec.file_time),
        encode_date(rec.file_date),
        rec.crc32,
        rec.compressed_size,
        rec.original_size,
        rec.filename_length,
        rec.extra_data_length
      )
    stream:write(chunk)

    stream:write(rec.filename)

    if (rec.extra_data_length ~= 0) then
      local raw_extra_data = compile_extra_data(rec.extra_data)
      stream:write(raw_extra_data)
    end

    if rec.data then
      stream:write(rec.data)
    end

    if rec.post_rec then
      local raw_post_rec = compile_post_file_rec(rec.post_rec)
      stream:write(raw_post_rec)
    end
  end
