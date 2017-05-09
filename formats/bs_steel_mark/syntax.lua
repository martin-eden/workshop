local handy = request('!.mechs.parser').handy

return
  {
    name = 'BS_steel_mark',
    handy.is_not(handy.match_regexp('2[5-9]')),
    handy.match_regexp('%d%d%d[AHMS]%d%d'),
  }
