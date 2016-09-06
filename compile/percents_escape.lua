local escape_string =
  function(s)
    local result
    result = s:gsub('.', function(c) return string.format('%%%X', string.byte(c, 1)) end)
    return result
  end

return escape_string
