-- Compile I2C reply message

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

--[[
  Input:
    [t] Me
    [i] device_id
    [i] offset
    [...] -- sequence of data bytes (integers)
]]

-- Imports:
local assert_device_id = request('!.concepts.i2c.assert_device_id')
local assert_byte = request('!.number.assert_byte')
local get_bits = request('!.number.get_bits')
local Signatures = request('!.concepts.firmata.protocol.signatures')

local compile_i2c_reply =
  function(Me, device_id, offset, ...)
    assert_device_id(device_id)
    assert_byte(offset)

    Me:emit(
      Signatures.sysex_start,
      Signatures.i2c_reply,
      get_bits(device_id, 0, 6),
      get_bits(device_id, 7, 13)
    )
    Me:emit_bytes(offset, ...)
    Me:emit(Signatures.sysex_end)
  end

-- Export:
return compile_i2c_reply

--[[
  2019 # #
  2026-05-30
]]
