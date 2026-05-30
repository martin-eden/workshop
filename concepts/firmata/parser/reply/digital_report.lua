-- Parse reply with port pins digital values

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

--[[
  Output

    [t]
      [i] port_index
      [t] pins -- boolean map of pin values

  Example:

    { port_index = 1, pins = { [8] = false, .. , [15] = true } }
]]

-- Imports:
local Signatures = request('!.concepts.firmata.protocol.signatures')
local get_bit = request('!.number.get_bit')

local parse_digital_report =
  function(Me, chunk, type_id)
    if (#chunk < 2) then return end

    local port_index = Signatures.digital_report[type_id]
    local value = Me:to_word(chunk:byte(1, 2))

    local Result =
      {
        port_index = port_index,
        pins = { },
      }

    local base_offset = port_index * 8

    for pin_offset = 0, 7 do
      Result.pins[base_offset + pin_offset] = get_bit(value, pin_offset)
    end

    return Result
  end

-- Export:
return parse_digital_report

--[[
  2019
  2026-05-30
]]
