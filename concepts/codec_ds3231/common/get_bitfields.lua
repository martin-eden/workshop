-- Load bitfields tree

--[[
  Author: Martin Eden
  Last mod.: 2026-06-07
]]

-- Imports:
local require_file = request('!.system.require_file')
local itness_from_str = request('!.convert.itness_from_str')
local ranges_tree_from_itness = request('!.convert.ranges_tree_from_itness')

local get_bitfields =
  function()
    local bitfields_filename =
      '!/concepts/codec_ds3231/common/ds3231_ranges_tree.is'

    local bitfields_is_str = require_file(bitfields_filename)
    local Bitfields_Is = itness_from_str(bitfields_is_str)

    return ranges_tree_from_itness(Bitfields_Is)
  end

-- Export:
return get_bitfields

--[[
  2026-05 # # #
  2026-06-07
]]
