-- Convert bytes list to string with bits

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local byte_to_bits = request('!.convert.byte_to_bits')
local add_to_list = request('!.concepts.list.add_item')
local list_to_string = request('!.concepts.list.to_string')

return
  function(bytes)
    assert_table(bytes)

    local bits = { }
    for idx, byte in ipairs(bytes) do
      add_to_list(bits, byte_to_bits(byte))
    end

    return list_to_string(bits)
  end

--[[
  2026 # #
]]
