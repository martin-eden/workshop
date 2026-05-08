-- Parse string with RTC DS3231 data

--[[
  Author: Martin Eden
  Last mod.: 2026-05-08
]]

-- Imports:
local bytes_from_str = request('!.convert.bytes_from_str')
local bits_from_bytes = request('!.convert.bits_from_bytes')
local apply_ranges_tree = request('!.concepts.RangesTree.apply_ranges_tree')
local create_string_val = request('!.concepts.RangesTree.StringValue.create')
local ds3231_values_from_bits = request('Internals.ds3231_values_from_bits')

local Parse =
  function(Me, data_str)
    assert_string(data_str)

    local DataBytes = bytes_from_str(data_str)

    local data_bits = bits_from_bytes(DataBytes)

    local BitsDataTree =
      apply_ranges_tree(data_bits, Me.Bitfields, create_string_val)

    return ds3231_values_from_bits(BitsDataTree)
  end

-- Export:
return Parse

--[[
  2026-05-04
  2026-05-05
  2026-05-06
]]
