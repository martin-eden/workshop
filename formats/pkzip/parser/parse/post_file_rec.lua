--[[
  In this great format, post-file record MAY contain 4-byte
  signature. Or maybe not. Looks like design was made by woman.

  What if (crc32 == signature)?

  Official record name: "Data descriptor".

  [signature, 4, 'PK\x07\x08']
  crc32, 4
  compressed_size, 4
  original_size, 4
]]

local record = '< c4 I4 I4 I4'
local rec_size = record:packsize()

local expected_sign = 'PK\x07\x08'

return
  function(stream)
    local chunk = stream:read(rec_size)

    local
      signature,
      crc32,
      compressed_size,
      original_size
      = record:unpack(chunk)

    if (signature == expected_sign) then
      -- Ahh, OK then.
    else
      -- Signature is missing. Reinterpret current values.
      signature, crc32, compressed_size, original_size =
        nil, signature, crc32, compressed_size
    end

    return
      {
        meta =
          {
            type = 'post_file_rec',
            signature = signature,
          },
        crc32 = crc32,
        compressed_size = compressed_size,
        original_size = original_size,
      }
  end
