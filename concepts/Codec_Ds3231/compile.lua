-- Compile DS3231 data to string

--[[
  Author: Martin Eden
  Last mod.: 2026-06-07
]]

-- Imports:
local ds3231_values_to_bits = request('compile.ds3231_values_to_bits')
local StringValue = request('!.concepts.RangesTree.StringValue.Interface')
local default_bit_char = request('!.concepts.BitChars').BitToChar_Map[false]
local get_bitfields = request('common.get_bitfields')
local fold_tree = request('!.concepts.RangesTree.fold_tree')
local bits_to_bytes = request('!.convert.bits_to_bytes')
local bytes_to_str = request('!.convert.bytes_to_str')

local compile =
  function(Ds3231_Data)
    assert_table(Ds3231_Data)

    local BitsDataTree = ds3231_values_to_bits(Ds3231_Data)

    local OutputStr = StringValue.create()
    OutputStr:SetDefaultItemValue(default_bit_char)

    local Bitfields = get_bitfields()

    local data_bits =
      fold_tree(BitsDataTree, Bitfields, OutputStr)

    return bytes_to_str(bits_to_bytes(data_bits))
  end

-- Export:
return compile

--[[
  2026-05 #
  2026-06-07
]]
