--[[
  Convert table with DS3231 values to array of bytes.

  Result data are supposed to be written to device.
]]

local generic_convert = request('mechs.generic_convert')

local stages =
  {
    {
      convert = request('converters.serialize'),
    },
  }

return
  function(data, do_verify, do_validate)
    return generic_convert(data, stages, do_verify, do_validate)
  end
