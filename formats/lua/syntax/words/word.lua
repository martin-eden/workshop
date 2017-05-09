local handy = request('!.mechs.processor.handy')
local match_regexp = request('!.mechs.parser.handy').match_regexp

local mid_letter = match_regexp('[_A-Za-z0-9]')

return
  function(...)
    local result = {...}
    result[#result + 1] = handy.is_not(mid_letter)
    return result
  end
