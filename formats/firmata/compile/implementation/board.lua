local num_pins = 20

local pin_modes =
  {
    [0] = 'input',
    [1] = 'output',
    [2] = 'analog',
    [3] = 'pwm',
    [4] = 'servo',
    [5] = 'shift',
    [6] = 'i2c',
    [7] = 'onewire',
    [8] = 'stepper',
    [9] = 'encoder',
    [10] = 'serial',
    [11] = 'pullup',
    [127] = 'ignore',
  }

local get_pin_analog_index =
  function(pin_number)
    assert_integer(pin_number)
    if (pin_number >= 14) and (pin_number <= 19) then
      return pin_number - 14
    else
      return false
    end
  end

local assert_valid_pin_number =
  function(pin_number)
    assert_integer(pin_number)
    assert((pin_number >= 0) and (pin_number < num_pins))
  end

local assert_valid_pin_mode =
  function(pin_mode)
    assert(pin_modes[pin_mode])
  end

return
  {
    num_pins = num_pins,
    pin_modes = pin_modes,
    get_pin_analog_index = get_pin_analog_index,
    assert_valid_pin_number = assert_valid_pin_number,
    assert_valid_pin_mode = assert_valid_pin_mode,
  }
