--[[
  Compile post-file record.

  Official record name: "Data descriptor".

  [signature, 4, 'PK\x07\x08']
  crc32, 4
  compressed_size, 4
  original_size, 4

  As signature is optional this creates problems in restoring file.
  For this reason signature, if present, is stored in <meta.signature>.
]]

local record = '< I4 I4 I4'

return
  function(rec)
    local result = {}

    table.insert(result, rec.meta.signature)

    local chunk =
      record:pack(
        rec.crc32,
        rec.compressed_size,
        rec.original_size
      )
    table.insert(result, chunk)

    result = table.concat(result)

    return result
  end
