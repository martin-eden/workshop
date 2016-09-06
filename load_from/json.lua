local quick_and_dirty_hack = request('json.qd')
local slow_and_clean_parser = request('json.via_parser')

local lazy_juggler =
  function(json_str)
    local result
    result =
      quick_and_dirty_hack(json_str) or
      slow_and_clean_parser(json_str)
    return result
  end

-- return lazy_juggler

return slow_and_clean_parser
-- return quick_and_dirty_hack
