--[[
  Function call grammar.

  Same structure as [var_ref] but must end in <call_args>.

  Sample:

    (a).b[c]:d()().e(f)(g){}""
            ~~~~~~  ~~~~~~~~~~ call_args
       ~~~~~      ~~           name_continuation
    ~~~                        name | par_expr
]]

local handy = request('!.mechs.processor.handy')
local cho = handy.cho
local rep = handy.rep
local opt_rep = handy.opt_rep
local is_not = handy.is_not

local name = request('^.words.name')
local par_expr = request('^.wrappers.par_expr')
local name_continuation = request('^.qualifiers.name_continuation')
local call_args = request('^.qualifiers.call_args')

return
  {
    name = 'function_call',
    cho(name, par_expr),
    rep(
      opt_rep(name_continuation),
      call_args
    ),
    is_not(name_continuation),
  }
