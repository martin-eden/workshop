--[[
  In I2C Firmata extension third byte of I2C read/write message
  have complex structure. This function generates this byte.

  It accepts list of parameters. Parameter may be boolean, integer
  or string.

    boolean - <auto_restart_transmission>
      any
        Makes sense when continious reading was enabled before.
        Default: false.

    string - <mode>
      'write'
      'read'
      'read_continiously' - continiously send read data
      'stop_reading' - stop sending read data

    integer - <device_id>
      any
        Must fit in 10 bits. (In 7 bits indeed due current Firmata
        implementation on Arduino.)
]]

local assert_device_id = request('!.formats.i2c.assert_device_id')
local modes = request('i2c_modes')

return
  function(...)
    local auto_restart_transmission = false
    local mode
    local device_id

    for i = 1, select('#', ...) do
      local term = select(i, ...)
      if is_boolean(term) then
        auto_restart_transmission = term
      elseif is_string(term) then
        mode = term
      elseif is_integer(term) then
        device_id = term
      else
        local msg =
          ('Bad argument type: "%s".'):format(type(term))
        error(msg)
      end
    end

    assert_boolean(auto_restart_transmission)
    assert(modes[mode])
    assert_device_id(device_id)

    local bit_6 = (auto_restart_transmission and 1) or 0
    local ten_bit_device_id = (device_id >= 0x80)
    local bit_5 = (ten_bit_device_id and 1) or 0
    local bits_34 = modes[mode]
    local bits_02 = (ten_bit_device_id and device_id >> 7) or 0

    local result =
      bits_02 | (bits_34 << 3) | (bit_5 << 5) | (bit_6 << 6)

    return result
  end
