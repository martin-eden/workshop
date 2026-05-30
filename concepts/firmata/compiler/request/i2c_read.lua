-- Compile I2C read request

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local assert_byte = request('!.number.assert_byte')
local Signatures = request('!.concepts.firmata.protocol.signatures')

local compile_i2c_read =
  function(Me, device_id, offset, num_bytes)
    assert_byte(offset)
    assert_byte(num_bytes)

    Me:emit(Signatures.sysex_start)
    Me:i2c_emit_request('read', device_id)
    Me:emit_bytes(offset, num_bytes)
    Me:emit(Signatures.sysex_end)
  end

-- Export:
return compile_i2c_read

--[[
  2019 # #
  2026-05-30
]]
