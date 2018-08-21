local compilers =
  {
    zip64 = request('extra_data.zip64_values'),
    ntfs = request('extra_data.ntfs_tags'),
    infozip_unix_extra = request('extra_data.infozip_unix_extra'),
    infozip_timestamp = request('extra_data.infozip_timestamp'),
    unknown = request('extra_data.unknown'),
  }

return
  function(extra_recs)
    assert_table(extra_recs)
    local result = {}
    for _, rec in ipairs(extra_recs) do
      local compile = compilers[rec.meta.type]
      assert(compile)
      local compiled = compile(rec)
      compiled = ('< c2 s2'):pack(rec.meta.signature, compiled)
      table.insert(result, compiled)
    end
    result = table.concat(result)
    return result
  end
