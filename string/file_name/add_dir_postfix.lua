return
  function(s)
    if (s:sub(-1) ~= '/') then
      s = s .. '/'
    end
    return s
  end
