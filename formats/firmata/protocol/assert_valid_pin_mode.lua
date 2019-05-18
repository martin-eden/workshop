local pin_modes = request('pin_modes')

return
  function(pin_mode)
    assert(pin_modes[pin_mode])
  end
