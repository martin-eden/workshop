local parser = request('^.^.^.parser')
local handy = parser.handy

local word = request('^.words.word')
local opt_spc = request('^.words.opt_spc')
local statements = request('statements')

local while_block =
  handy.interleave(
    {
      name = 'while_block',
      word('while'),
      '>expression',
      word('do'),
      statements,
      word('end'),
    },
    opt_spc
  )

return while_block
