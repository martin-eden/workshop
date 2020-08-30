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
    {
      verify = request('verificators.verify_moment_year'),
      validate = request('validators.fix_moment_year'),
    },
    {
      verify = request('verificators.verify_moment_month'),
      validate = request('validators.fix_moment_month'),
    },
    {
      verify = request('verificators.verify_moment_monthday'),
      validate = request('validators.fix_moment_monthday'),
    },
    {
      verify = request('verificators.verify_moment_hour'),
      validate = request('validators.fix_moment_hour'),
      parse = request('parsers.adjust_moment_hour'),
    },
    {
      verify = request('verificators.verify_moment_minute'),
      validate = request('validators.fix_moment_minute'),
    },
    {
      verify = request('verificators.verify_moment_second'),
      validate = request('validators.fix_moment_second'),
    },
    {
      -- verify = request('verificators.verify_alarm_flags'),
      -- validate = request('validators.fix_alarm_flags'),
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
