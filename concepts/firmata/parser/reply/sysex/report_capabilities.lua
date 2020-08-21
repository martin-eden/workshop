local mode_names = request('!.concepts.firmata.protocol.mode_names')

local parse_pin_capabilities =
  function(chunk)
    local result = {}
    for mode, resolution in chunk:gmatch('(.)(.)') do
      local mode_name = mode_names[mode:byte()]
      if not mode_name then
        error(('No name for mode %02X'):format(mode:byte()))
      end
      result[mode_name] = resolution:byte()
    end
    return result
  end

-- Payload is a pin sequence delimited by 0x7F.
local get_part_fmt = '(.-)\x7F'

return
  function(self, chunk)
    local result = {}

    local pin_index = 0
    for sub_chunk in chunk:gmatch(get_part_fmt) do
      result[pin_index] = parse_pin_capabilities(sub_chunk)
      pin_index = pin_index + 1
    end
    result.num_pins = pin_index

    return result
  end
