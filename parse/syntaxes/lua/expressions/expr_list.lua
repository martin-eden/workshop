local parser = request('^.^.^.parser')
local handy = parser.handy

local opt_spc = request('^.words.opt_spc')

local expr_list =
  {
    name = 'expr_list',
    handy.list({opt_spc, '>expression'}, {opt_spc, ','}),
  }

return expr_list
