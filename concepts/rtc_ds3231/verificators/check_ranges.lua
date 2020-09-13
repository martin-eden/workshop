--[[
  Check that parse table values are in valid ranges.

  "Valid" means it can be stored without issues. Not that they are
  semantically valid.

  This ranges derived from storage format in [serialize].
]]

local path_get_value = request('!.table.path_get_value')
local in_range = request('!.number.in_range')

-- Value ranges. Hour records processed separately.
local ranges =
  {
    {path = {'moment', 'second'}, min = 0, max = 79},
    {path = {'moment', 'minute'}, min = 0, max = 79},
    {path = {'moment', 'dow'}, min = 0, max = 7},
    {path = {'moment', 'date'}, min = 0, max = 39},
    {path = {'moment', 'month'}, min = 0, max = 19},
    {path = {'moment', 'year'}, min = 0, max = 99},

    {path = {'alarm_1', 'second'}, min = 0, max = 79},
    {path = {'alarm_1', 'minute'}, min = 0, max = 79},
    {path = {'alarm_1', 'date_dow'}, min = 0, max = 39},

    {path = {'alarm_2', 'minute'}, min = 0, max = 79},
    {path = {'alarm_2', 'date_dow'}, min = 0, max = 39},

    {path = {'clock_speed'}, min = -128, max = 127},
    {path = {'temperature'}, min = -128.0, max = 127.75},
  }

local hour_paths =
  {
    {'moment', 'hour'},
    {'alarm_1', 'hour'},
    {'alarm_2', 'hour'},
  }

-- Hour range depends whether we store in 12h or 24h format.
local hour_ranges =
  {
    [false] = {min = 0, max = 39},
    [true] = {min = 0, max = 19},
  }

local process =
  function(path, value, min, max)
    if not in_range(value, min, max) then
      coroutine.yield(path, value, min, max)
    end
  end

return
  function(data)
    for _, range in ipairs(ranges) do
      local value = path_get_value(data, range.path)
      process(range.path, value, range.min, range.max)
    end
    -- Process hour recs.
    for _, path in ipairs(hour_paths) do
      local value = path_get_value(data, path)
      local is_ampm = path_get_value(data, path, -2).is_12h_format
      process(
        path,
        value,
        hour_ranges[is_ampm].min,
        hour_ranges[is_ampm].max
      )
    end
  end
