local word = request('^.words.word')
local opt_spc = request('^.words.opt_spc')
local name = request('^.words.name')

local goto_statement =
  {
    name = 'goto_statement',
    word('goto'),
    opt_spc, name,
  }

return goto_statement
