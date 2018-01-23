local handy = request('!.mechs.processor.handy')
local list = handy.list

local var_ref = request('^.qualifiers.var_ref')
local syntel = request('^.words.syntel')
local expr_list = request('^.wrappers.expr_list')

return
  {
    name = 'assignment',
    list(var_ref, syntel(',')),
    syntel('='),
    expr_list
  }
