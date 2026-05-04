-- Convert string data to string with bits

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

--[[
  Result structure

    string
]]

-- Imports:
local get_bit = request('!.number.get_bit')
local add_to_list = request('!.concepts.list.add_item')
local list_to_string = request('!.concepts.list.to_string')

local BitChars_Map =
  {
    [false] = '.',
    [true] = 'X',
  }

local bits_from_str =
  function(data_str)
    -- This implementation is not designed to be fast or smart

    -- Bits order is least-significant-bit first

    local BytesBits = { }

    for char_idx = 1, #data_str do
      local char = string.sub(data_str, char_idx, char_idx)
      local byte = string.byte(char)
      local byte_bits = ''
      for bit_idx = 0, 7 do
        local bit = get_bit(byte, bit_idx)
        local bit_char = BitChars_Map[bit]
        byte_bits = byte_bits .. bit_char
      end
      add_to_list(BytesBits, byte_bits)
    end

    return list_to_string(BytesBits)
  end

-- Export:
return bits_from_str

--[[
  2026-05-03
]]
