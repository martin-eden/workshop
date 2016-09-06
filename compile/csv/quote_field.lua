local quote_field =
  function(s)
    s = '"' .. s:gsub('"', '""') .. '"'
    return s
  end

return quote_field
