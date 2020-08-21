return
  function(self, chunk)
    if (#chunk < 2) then
      return
    end

    return
      {
        major = chunk:byte(1),
        minor = chunk:byte(2),
      }
  end
