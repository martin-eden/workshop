--[[
  Convert table with DS3231 values to array of bytes.

  Result data are supposed to be written to device.
]]

local generic_convert = request('!.mechs.generic_convert')

local stages =
  {
    {
      verify = request('verificators.check_final_structure'),
      validate = request('validators.fix_final_structure'),
    },
    {convert = request('converters.hours_denormalize')},
    {convert = request('converters.year_pack')},
    {
      verify = request('verificators.check_ranges'),
      validate = request('validators.constrain_number'),
      convert = request('converters.ints_to_bcds'),
    },
    {convert = request('converters.serialize')},
    {
      verify = request('verificators.check_masks'),
      validate = request('validators.apply_mask'),
    },
  }

return
  function(data, do_verify, do_validate)
    return generic_convert(data, stages, do_verify, do_validate)
  end
