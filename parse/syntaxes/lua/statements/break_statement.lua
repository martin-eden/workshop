local word = request('^.words.word')

local break_statement =
  {
    name = 'break_statement',
    word('break'),
  }

return break_statement
