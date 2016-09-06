local opt_spc = request('^.words.opt_spc')

local bracket_expr =
  {
    name = 'bracket_expr',
    '[',
    opt_spc, '>expression',
    opt_spc, ']',
  }

return bracket_expr
