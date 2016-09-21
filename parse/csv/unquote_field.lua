return
  function(s)
    if
      (#s >= 2) and
      (s:sub(1, 1) == '"') and
      (s:sub(-1, -1) == '"')
    then
      s = s:sub(2, -2)
      s = s:gsub('""', '"')
    end
    return s
  end
