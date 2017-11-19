local handy = request('!.mechs.processor.handy')

local word = request('^.words.word')
local syntel = request('^.words.syntel')
local name = request('^.words.name')
local statements = request('statements')

return
  {
    name = 'numeric_for_block',
    word('for'),
    name,
    syntel('='),
    '>expression',
    syntel(','),
    '>expression',
    handy.opt(
      syntel(','),
      '>expression'
    ),
    word('do'),
    statements,
    word('end'),
  }
