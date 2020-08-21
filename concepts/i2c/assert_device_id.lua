return
  function(device_id)
    assert_integer(device_id)
    if (device_id ~= (device_id & 0x3FF)) then
      local msg =
        ('Given device id 0x%X does not fit in 10 bits (0x00/0x3FF'):
        format(device_id)
      error(msg, 2)
    end
  end
