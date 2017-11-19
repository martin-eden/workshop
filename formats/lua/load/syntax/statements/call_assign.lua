local handy = request('!.mechs.processor.handy')

local var_link = request('^.expressions.var_link')
local syntel = request('^.words.syntel')
local expr_list = request('^.expressions.expr_list')

return
  {
    name = 'call_assign',
    handy.list(var_link, syntel(',')),
    handy.opt(
      syntel('='),
      expr_list
    ),
  }
