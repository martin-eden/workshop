-- Parse string with RTC DS3231 data

--[[
  Author: Martin Eden
  Last mod.: 2026-05-08
]]

-- Imports:
local bytes_from_str = request('!.convert.bytes_from_str')
local bits_from_bytes = request('!.convert.bits_from_bytes')
local StringValue = request('!.concepts.RangesTree.StringValue.Interface')
local apply_ranges_tree = request('!.concepts.RangesTree.apply_ranges_tree')
local ds3231_values_from_bits = request('Internals.ds3231_values_from_bits')

local Parse =
  function(Me, data_str)
    assert_string(data_str)

    local DataBytes = bytes_from_str(data_str)

    local data_bits = bits_from_bytes(DataBytes)

    local InputStr = StringValue.create()
    InputStr:SetValue(data_bits)

    local OutputStr = StringValue.create()

    local BitsDataTree =
      apply_ranges_tree(InputStr, Me.Bitfields, OutputStr)

    return ds3231_values_from_bits(BitsDataTree)
  end

-- Export:
return Parse

--[[
  2026-05-04
  2026-05-05
  2026-05-06
]]
