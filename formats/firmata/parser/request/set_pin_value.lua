return
  function(self, chunk)
    if (#chunk < 2) then
      return
    end

    return
      {
        pin_number = chunk:byte(1),
        pin_value = chunk:byte(2),
      }
  end
