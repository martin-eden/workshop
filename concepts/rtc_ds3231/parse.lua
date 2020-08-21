--[[
  Convert table with DS3231 array of bytes to structured table.

  Has options to verify (and validate) data. Table with behavior
  options may be passed as second argument.
]]

local generic_parse = request('generic_parse')

local stages =
  {
    {
      verify = request('verificators.pass_1'),
      validate = request('validators.pass_1'),
    },
    {
      verify = request('verificators.pass_2'),
      validate = request('validators.pass_2'),
      parse = request('parsers.categorize'),
    },
    {
      verify = request('verificators.pass_bcd'),
      validate = request('validators.pass_bcd'),
      parse = request('parsers.convert_bcds'),
    },
    {
      parse = request('parsers.augment_year'),
    },
  }

local default_options =
  {
    do_verify = true,
    do_validate = true,
  }

return
  function(data, options)
    local options = new(default_options, options)
    return generic_parse(data, stages, options.do_verify, options.do_validate)
  end
