local handy = request('!.mechs.processor.handy')
local opt = handy.opt
local list = handy.list

local var_link = request('^.expressions.var_link')
local syntel = request('^.words.syntel')
local expr_list = request('^.expressions.expr_list')

return
  {
    name = 'call_assign',
    list(var_link, syntel(',')),
    opt(
      syntel('='),
      expr_list
    ),
  }
