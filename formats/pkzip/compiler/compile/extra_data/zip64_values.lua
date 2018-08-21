return
  function(rec)
    local result = {}

    if rec.original_size then
      table.insert(result, ('< I8'):pack(rec.original_size))
    end
    if rec.compressed_size then
      table.insert(result, ('< I8'):pack(rec.compressed_size))
    end
    if rec.file_offset then
      table.insert(result, ('< I8'):pack(rec.file_offset))
    end
    if rec.file_disk then
      table.insert(result, ('< I4'):pack(rec.file_disk))
    end

    result = table.concat(result)

    return result
  end
