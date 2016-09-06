local name = request('^.words.name')
local opt_spc = request('^.words.opt_spc')

local label_statement =
  {
    name = 'label_statement',
    '::',
    opt_spc, name,
    opt_spc, '::',
  }

return label_statement
