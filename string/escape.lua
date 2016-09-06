local chunk_name = 'escape'

local escape_string =
  function(s)
    local result
    result = s:gsub('.', function(c) return string.format('%%%X', string.byte(c, 1)) end)
    return result
  end

tribute(chunk_name, escape_string)
