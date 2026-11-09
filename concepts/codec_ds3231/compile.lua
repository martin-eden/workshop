-- Compile DS3231 data to string

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local ds3231_values_to_bits = request('compile.ds3231_values_to_bits')
local string_value =
  request('!.concepts.RangesTree.StringValue.Interface')
local default_bit_char =
  request('!.concepts.bit_chars').bit_to_char_map[false]
local get_bitfields = request('common.get_bitfields')
local fold_tree = request('!.concepts.RangesTree.fold_tree')
local bits_to_bytes = request('!.convert.bits_to_bytes')
local bytes_to_str = request('!.convert.bytes_to_str')

return
  function(ds3231_data)
    assert_table(ds3231_data)

    local bits_data_tree = ds3231_values_to_bits(ds3231_data)

    local output_str = string_value.create()
    output_str:SetDefaultItemValue(default_bit_char)

    local bitfields = get_bitfields()

    local data_bits =
      fold_tree(bits_data_tree, bitfields, output_str)

    return bytes_to_str(bits_to_bytes(data_bits))
  end

--[[
  2026-05 #
  2026-06-07
]]
