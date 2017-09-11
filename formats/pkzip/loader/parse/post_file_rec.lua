--[[
  In this great format, post-file record MAY contain 4-byte
  signature. Or maybe not. Looks like design was made by woman.

  [signature, 4, 'PK\x07\x08']
  crc_32, 4
  compressed_size, 4
  original_size, 4

]]

return
  function(self)
    local in_stream = self.in_stream

    local signature, crc_32, compressed_size, original_size

    signature = in_stream:read(4)
    if (signature == self.signatures.post_file_rec) then
      -- Oh, ok then
      crc_32 = in_stream:read(4)
    else
      crc_32 = signature
      signature = nil
    end

    compressed_size = in_stream:read(4)
    compressed_size = ('< I4'):unpack(compressed_size)

    original_size = in_stream:read(4)
    original_size = ('< I4'):unpack(original_size)

    return
      {
        signature = signature,
        crc_32 = crc_32,
        compressed_size = compressed_size,
        original_size = original_size,
      }
  end
