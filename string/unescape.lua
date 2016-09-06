local chunk_name = 'unescape'

local unescape_string =
  function(s)
    local result
    result =
      s:gsub(
        '%%(%x%x)',
        function(m)
          return string.char(tonumber(m, 16))
        end
      )
    return result
  end


tribute(chunk_name, unescape_string)
