return
  function(rec)
    local result = {}
    table.insert(result, ('B'):pack(rec.version))
    if (rec.version == 1) then
      table.insert(result, ('< s1 s1'):pack(rec.uid, rec.gid))
    else
      table.insert(result, rec.unparsed_data)
    end
    result = table.concat(result)
    return result
  end
