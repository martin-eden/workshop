-- DS3231 codec methods

--[[
  Author: Martin Eden
  Last mod.: 2026-05-08
]]

-- Imports:
local require_file = request('!.system.require_file')
local itness_from_str = request('!.convert.itness_from_str')
local ranges_tree_from_itness = request('!.convert.ranges_tree_from_itness')
local attach_methods = request('!.table.attach_methods')

local Methods =
  {
    Parse = request('Parse'),
    Compile = request('Compile'),
  }

-- Load bitfields tree
local get_bitfields =
  function()
    local bitfields_filename =
      '!/concepts/codec_ds3231/Internals/ds3231_ranges_tree.is'

    local bitfields_is_str = require_file(bitfields_filename)
    local Bitfields_Is = itness_from_str(bitfields_is_str)

    return ranges_tree_from_itness(Bitfields_Is)
  end

-- Create codec
Methods.create =
  function()
    local Result = { Bitfields = get_bitfields() }

    attach_methods(Result, Methods)

    return Result
  end

-- Export:
return Methods

--[[
  2026-05-07
]]
