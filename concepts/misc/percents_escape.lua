return
  function(s)
    return
      s:gsub(
        '.',
        function(c)
          return string.format('%%%X', string.byte(c, 1))
        end
      )
  end
