local compile_ntfs_mtimes = request('ntfs_mtimes')

local times_tag = '\x01\x00'

return
  function(rec)
    local result = {}

    table.insert(result, rec.reserved)

    local tag, data
    if rec.mtimes then
      tag = times_tag
      data = compile_ntfs_mtimes(rec.mtimes)
    else
      tag = rec.tag
      data = rec.chunk
    end
    table.insert(result, ('< c2 s2'):pack(tag, data))

    result = table.concat(result)

    return result
  end
