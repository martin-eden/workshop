-- Convert string with bits to list of bytes

--[[
  Author: Martin Eden
  Last mod.: 2026-05-08
]]

-- Imports:
local byte_from_bits = request('!.convert.byte_from_bits')
local add_to_list = request('!.concepts.list.add_item')

local bits_to_bytes =
  function(bits_str)
    --[[
      We thought about using regexp to slice byte 8 chars but rejected.
      We want readability.
    ]]

    local bits_str_len = string.len(bits_str)

    local Bytes = { }

    local slice_start_pos = 1
    while (slice_start_pos <= bits_str_len) do
      local slice =
        string.sub(
          bits_str,
          slice_start_pos,
          slice_start_pos + 8 - 1
        )
      add_to_list(Bytes, byte_from_bits(slice))
      slice_start_pos = slice_start_pos + 8
    end

    return Bytes
  end

-- Export:
return bits_to_bytes

--[[
  2026-05-08
]]
