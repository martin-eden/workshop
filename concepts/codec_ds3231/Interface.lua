-- DS3231 codec methods

--[[
  Author: Martin Eden
  Last mod.: 2026-05-12
]]

--[[
  Interface

    Parse [f]
    Compile [f]
]]

-- Imports:
local require_file = request('!.system.require_file')
local itness_from_str = request('!.convert.itness_from_str')
local ranges_tree_from_itness = request('!.convert.ranges_tree_from_itness')

-- Load bitfields tree
local get_bitfields =
  function()
    local bitfields_filename =
      '!/concepts/codec_ds3231/Internals/ds3231_ranges_tree.is'

    local bitfields_is_str = require_file(bitfields_filename)
    local Bitfields_Is = itness_from_str(bitfields_is_str)

    return ranges_tree_from_itness(Bitfields_Is)
  end

local Interface =
  {
    -- Main:
    Parse = request('Parse'),
    Compile = request('Compile'),

    -- Internals:
    Bitfields = get_bitfields()
  }

-- Export:
return Interface

--[[
  2026-05-07
  2026-05-10
  2026-05-12
]]
