-- Compile I2C request for continuous reads

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local assert_byte = request('!.number.assert_byte')
local Signatures = request('!.concepts.firmata.protocol.signatures')

local compile_i2c_read_cont =
  function(self, device_id, offset, num_bytes)
    assert_byte(offset)
    assert_byte(num_bytes)

    local restart_reads = true

    self:emit(Signatures.sysex_start)
    self:i2c_emit_request('read_continiously', device_id, restart_reads)
    self:emit_bytes(offset, num_bytes)
    self:emit(Signatures.sysex_end)
  end

-- Export:
return compile_i2c_read_cont

--[[
  2019
  2026-05-30
]]
