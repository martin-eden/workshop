local handy = request('!.mechs.processor.handy')
local match_regexp = request('!.mechs.parser.handy').match_regexp

return
  {
    name = 'BS_steel_mark',
    handy.is_not(match_regexp('2[5-9]')),
    match_regexp('%d%d%d[AHMS]%d%d'),
  }
