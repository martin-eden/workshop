--[[
  Convert table with DS3231 array of bytes to structured table.

  In additional arguments you can pass two optional boolean values
  to override default values for <do_verify> and <do_validate>.
  Default values for them are both true.

  Returns table with parsed data.
]]

local generic_convert = request('!.mechs.generic_convert')

local stages =
  {
    {
      verify = request('verificators.check_bytes'),
      validate = request('validators.fix_byte'),
      convert = request('converters.categorize'),
    },
    {
      verify = request('verificators.check_bcds'),
      validate = request('validators.to_bcd'),
      convert = request('converters.bcds_to_ints'),
    },
    {convert = request('converters.year_unpack')},
    {convert = request('converters.hours_normalize')},
  }

return
  function(data, do_verify, do_validate)
    return generic_convert(data, stages, do_verify, do_validate)
  end
