-- Convert table with DS3231 values to array of bytes

--[[
  Author: Martin Eden
  Last mod.: 2026-04-30
]]

-- Imports:
local generic_convert = request('!.mechs.generic_convert')

local Stages =
  {
    {
      verify = request('verificators.check_final_structure'),
      validate = request('validators.fix_final_structure'),
    },
    { convert = request('converters.hours_denormalize') },
    { convert = request('converters.year_pack') },
    {
      verify = request('verificators.check_ranges'),
      validate = request('validators.constrain_number'),
      convert = request('converters.ints_to_bcds'),
    },
    { convert = request('converters.serialize') },
    {
      verify = request('verificators.check_masks'),
      validate = request('validators.apply_mask'),
    },
  }

local compile =
  function(Data, do_verify, do_validate)
    return generic_convert(Data, Stages, do_verify, do_validate)
  end

-- Export:
return compile

--[[
  2019 # # # # # # # # #
  2020 # # # # #
  2026-04-30
]]
