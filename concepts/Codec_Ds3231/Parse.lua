-- Parse string with RTC DS3231 data

--[[
  Author: Martin Eden
  Last mod.: 2026-06-07
]]

-- Imports:
local StringValue = request('!.concepts.RangesTree.StringValue.Interface')
local bytes_from_str = request('!.convert.bytes_from_str')
local bits_from_bytes = request('!.convert.bits_from_bytes')
local apply_ranges_tree = request('!.concepts.RangesTree.apply_ranges_tree')
local ds3231_values_from_bits = request('Internals.ds3231_values_from_bits')

local Parse =
  function(Me, data_str)
    local InputStr = StringValue.create()
    InputStr:SetValue(bits_from_bytes(bytes_from_str(data_str)))

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
