local handy = request('!.mechs.processor.handy')

local syntel = request('^.words.syntel')

return
  {
    name = 'expr_list',
    handy.list('>expression', syntel(',')),
  }
