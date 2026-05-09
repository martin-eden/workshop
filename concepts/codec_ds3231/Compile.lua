-- Compile DS3231 data to string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-09
]]

-- Imports:
local ds3231_values_to_bits = request('Internals.ds3231_values_to_bits')
local StringValue = request('!.concepts.RangesTree.StringValue.Interface')
local fold_tree = request('!.concepts.RangesTree.fold_tree')
local bits_to_bytes = request('!.convert.bits_to_bytes')
local bytes_to_str = request('!.convert.bytes_to_str')

local Compile =
  function(Me, Ds3231_Data)
    local default_bit_char = '.'

    assert_table(Ds3231_Data)

    local BitsDataTree = ds3231_values_to_bits(Ds3231_Data)

    local OutputStr = StringValue.create()
    OutputStr:SetDefaultItemValue(default_bit_char)

    local data_bits =
      fold_tree(BitsDataTree, Me.Bitfields, OutputStr)

    local DataBytes = bits_to_bytes(data_bits)

    return bytes_to_str(DataBytes)
  end

-- Export:
return Compile

--[[
  2026-05-07
]]
