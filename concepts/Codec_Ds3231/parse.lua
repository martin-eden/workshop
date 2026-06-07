-- Parse string with RTC DS3231 data

--[[
  Author: Martin Eden
  Last mod.: 2026-06-07
]]

-- Imports:
local StringValue = request('!.concepts.RangesTree.StringValue.Interface')
local bytes_from_str = request('!.convert.bytes_from_str')
local bits_from_bytes = request('!.convert.bits_from_bytes')
local get_bitfields = request('common.get_bitfields')
local apply_ranges_tree = request('!.concepts.RangesTree.apply_ranges_tree')
local ds3231_values_from_bits = request('parse.ds3231_values_from_bits')

local parse =
  function(data_str)
    assert_string(data_str)

    local InputStr = StringValue.create()
    InputStr:SetValue(bits_from_bytes(bytes_from_str(data_str)))

    local Bitfields = get_bitfields()

    local BitsDataTree =
      apply_ranges_tree(InputStr, Bitfields, StringValue)

    return ds3231_values_from_bits(BitsDataTree)
  end

-- Export:
return parse

--[[
  2026-05 # # #
  2026-06-07
]]
