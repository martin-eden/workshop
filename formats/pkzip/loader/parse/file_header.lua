--[[
  signature, 'PK\x01\x02'
  version_to_extract, 2
  version_made_by, 2
  bit_flag, 2
  compression_method, 2
  file_time, 2
  file_date, 2
  crc_32, 4
  compressed_size, 4
  original_size, 4
  filename_length, 2
  additional_data_length, 2
  comment_length, 2
  file_disk, 2
  internal_file_attributes, 2
  external_file_attributes, 4
  file_offset, 4
  filename, <filename_length>
  additional_data, <additional_data_length>
  comment, <comment_length>
]]

local format = '< c4 I2 I2 c2 I2 c2 c2 c4 I4 I4 I2 I2 I2 I2 c2 c4 I4'

return
  function(self)
    local chunk = self.in_stream:read(format:packsize())

    local results = {format:unpack(chunk)}
    results[#results] = nil

    local
      signature,
      version_to_extract,
      version_made_by,
      bit_flag,
      compression_method,
      file_time,
      file_date,
      crc_32,
      compressed_size,
      original_size,
      filename_length,
      additional_data_length,
      comment_length,
      file_disk,
      internal_file_attributes,
      external_file_attributes,
      file_offset =
      table.unpack(results)

    assert(signature == self.signatures.file, 'Signature mismatch.')

    local filename = self.in_stream:read(filename_length)
    local additional_data = self.in_stream:read(additional_data_length)
    local comment = self.in_stream:read(comment_length)

    return
      {
        signature = signature,
        version_to_extract = version_to_extract,
        version_made_by = version_made_by,
        bit_flag = bit_flag,
        compression_method = compression_method,
        file_time = file_time,
        file_date = file_date,
        crc_32 = crc_32,
        compressed_size = compressed_size,
        original_size = original_size,
        filename_length = filename_length,
        additional_data_length = additional_data_length,
        comment_length = comment_length,
        file_disk = file_disk,
        internal_file_attributes = internal_file_attributes,
        external_file_attributes = external_file_attributes,
        file_offset = file_offset,
        filename = filename,
        additional_data = additional_data,
        comment = comment,
      }
  end
