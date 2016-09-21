return
  function(s)
    s = '"' .. s:gsub('"', '""') .. '"'
    return s
  end
