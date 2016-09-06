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

return unescape_string
