local num_pins = request('num_pins')

return
  function(pin_number)
    assert_integer(pin_number)
    if (pin_number >= 14) and (pin_number < num_pins) then
      return pin_number - 14
    else
      return false
    end
  end
