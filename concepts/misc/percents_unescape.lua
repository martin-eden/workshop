return
  function(s)
    return
      s:gsub(
        '%%(%x%x)',
        function(m)
          return string.char(tonumber(m, 16))
        end
      )
  end
