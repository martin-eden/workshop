-- Parse string with RTC DS3231 data

--[[
  Author: Martin Eden
  Last mod.: 2026-11-26
]]

local string_val = request('!.concepts.RangesTree.StringValue.Interface')
local bytes_from_str = request('!.convert.bytes_from_str')
local bits_from_bytes = request('!.convert.bits_from_bytes')
local get_bitfields = request('common.get_bitfields')
local apply_ranges_tree = request('!.concepts.RangesTree.apply_ranges_tree')
local ds3231_values_from_bits = request('parse.ds3231_values_from_bits')

return
  function(data_str)
    local input_str = string_val.create()
    input_str:SetValue(bits_from_bytes(bytes_from_str(data_str)))
    local bits_datatree =
      apply_ranges_tree(input_str, get_bitfields(), string_val)
    return ds3231_values_from_bits(bits_datatree)
  end

--[[
  2026 # # # #
]]
