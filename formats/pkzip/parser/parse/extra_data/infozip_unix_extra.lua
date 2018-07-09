return
  function(data)
    local result = {}
    local version, start_pos = ('< I1'):unpack(data)
    result.version = version
    if (version == 1) then
      result.uid, result.gid = ('< s1 s1'):unpack(data, start_pos)
    else
      result.unparsed_data = data:sub(start_pos)
    end
    return result
  end
