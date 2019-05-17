local num_pins = request('num_pins')

return
  function(pin_number)
    assert_integer(pin_number)
    assert((pin_number >= 0) and (pin_number < num_pins))
  end
