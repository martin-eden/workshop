-- Convert string data to string with bits

--[[
  Author: Martin Eden
  Last mod.: 2026-05-07
]]

--[[
  Result structure

    string
]]

-- Imports:
local byte_to_bits = request('!.convert.byte_to_bits')
local add_to_list = request('!.concepts.list.add_item')
local list_to_string = request('!.concepts.list.to_string')

local bits_from_str =
  function(data_str)
    assert_string(data_str)

    local BytesBits = { }

    for char_idx = 1, string.len(data_str) do
      local char = string.sub(data_str, char_idx, char_idx)
      local byte = string.byte(char)
      add_to_list(BytesBits, byte_to_bits(byte))
    end

    return list_to_string(BytesBits)
  end

-- Export:
return bits_from_str

--[[
  2026-05-03
]]
