local handy = request('!.mechs.processor.handy')

local word = request('words.word')

return
  {
    name = 'boolean',
    word(handy.cho('false', 'true')),
  }
