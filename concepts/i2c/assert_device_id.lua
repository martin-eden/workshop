-- Assert that given argument is 10-bit integer (device id)

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local get_bits = request('!.number.get_bits')

local assert_device_id =
  function(device_id)
    assert_integer(device_id)

    if (device_id ~= get_bits(device_id, 0, 9)) then
      local msg =
        string.format(
          'Given device id 0x%X is not fitting in 10 bits.',
          device_id
        )
      error(msg, 2)
    end
  end

-- Export:
return assert_device_id

--[[
  2019
  2026-05-30
]]
