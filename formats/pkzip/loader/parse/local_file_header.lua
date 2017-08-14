--[[
  signature, 'PK\x03\x04'
  version_to_extract, 2
  bit_flag, 2
  compression_method, 2
  file_time, 2
  file_date, 2
  crc_32, 4
  compressed_size, 4
  original_size, 4
  filename_length, 2
  additional_data_length, 2
  filename, <filename_length>
  additional_data, <additional_data_length>
  data, <compressed_size>

  if bit_is_set(<bit_flag>, 3)
    parse(@data_descriptor)

  ' <compressed_size> may be stored in "file header" if 3'rd bit of
  ' <bit_flag> is set. Have a nice day!
]]

local format = '< c4 I2 c2 I2 c2 c2 c4 I4 I4 I2 I2'

return
  function(self)
    local in_stream = self.in_stream

    local chunk = in_stream:read(format:packsize())

    local results = {format:unpack(chunk)}
    results[#results] = nil

    local
      signature,
      version_to_extract,
      bit_flag,
      compression_method,
      file_time,
      file_date,
      crc_32,
      compressed_size,
      original_size,
      filename_length,
      additional_data_length =
      table.unpack(results)

    assert(signature == self.signatures.local_file, 'Signature mismatch.')

    local filename = in_stream:read(filename_length)
    local additional_data = in_stream:read(additional_data_length)

    return
      {
        signature = signature,
        version_to_extract = version_to_extract,
        bit_flag = bit_flag,
        compression_method = compression_method,
        file_time = file_time,
        file_date = file_date,
        crc_32 = crc_32,
        compressed_size = compressed_size,
        original_size = original_size,
        filename_length = filename_length,
        additional_data_length = additional_data_length,
        filename = filename,
        additional_data = additional_data,
      }
  end
