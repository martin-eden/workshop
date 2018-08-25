--[[
  Compile post-file record.

  Official record name: "Data descriptor".

  [signature, 4, 'PK\x07\x08']
  crc32, 4
  compressed_size, 4
  original_size, 4

  As signature is optional this creates problems in restioring file.
  For this reason signature, if present, is stored in <meta.signature>.
]]

local record = '< I4 I4 I4'

return
  function(rec, stream)
    stream:set_position(rec.meta.offset + 1)

    if rec.meta.signature then
      stream:write(rec.meta.signature)
    end

    local chunk =
      record:pack(
        rec.crc32,
        rec.compressed_size,
        rec.original_size
      )
    stream:write(chunk)
  end
