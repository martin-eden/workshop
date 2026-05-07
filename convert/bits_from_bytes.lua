-- Convert bytes list to string with bits

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

local bits_from_bytes =
  function(Bytes)
    assert_table(Bytes)

    local BytesBits = { }

    for idx, byte in ipairs(Bytes) do
      add_to_list(BytesBits, byte_to_bits(byte))
    end

    return list_to_string(BytesBits)
  end

-- Export:
return bits_from_bytes

--[[
  2026-05-03
  2026-05-07
]]
