--[[
  Variable reference grammar.

  Same structure as [function_call] but must not end at <call_args>.

  Sample:

    (a).b[c]:d()().e(f)(g){}"".h
            ~~~~~~  ~~~~~~~~~~   call_args
       ~~~~~      ~~          ~~ name_continuation
    ~~~                          name | par_expr
]]

local handy = request('!.mechs.processor.handy')
local cho = handy.cho
local opt_rep = handy.opt_rep
local is_not = handy.is_not

local name = request('^.words.name')
local par_expr = request('^.wrappers.par_expr')
local call_args = request('^.qualifiers.call_args')
local name_continuation = request('^.qualifiers.name_continuation')

return
  {
    name = 'var_ref',
    cho(name, par_expr),
    opt_rep(
      opt_rep(call_args),
      name_continuation
    ),
    is_not(call_args),
  }
