--[[
  Convert table with DS3231 values to array of bytes.

  Result data are supposed to be written to device.
]]

local generic_convert = request('mechs.generic_convert')

local stages =
  {
    {convert = request('converters.hours_denormalize')},
    {convert = request('converters.year_pack')},
    {convert = request('converters.ints_to_bcds')},
    {convert = request('converters.serialize')},
    {
      verify = request('verificators.pass_masks'),
      validate = request('validators.pass_masks'),
    },
  }

return
  function(data, do_verify, do_validate)
    return generic_convert(data, stages, do_verify, do_validate)
  end
