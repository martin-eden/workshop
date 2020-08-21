--[[
  Expression grammar.

  <expression>:

    -+---------------+---+- ... -----------+---+-----------------------------+-
     | ------------- |   +- <nil> ---------+   | --------------------------- |
     | V           / |   +- <boolean>------+   | V                         / |
     +--- <un_op> ---+   +- <number> ------+   +--- <bin_op> <expression> ---+
                         +- <string> ------+
                         +- <table> -------+
                         +- <function> ----+
                         +- <var_or_call> -+
]]

local handy = request('!.mechs.processor.handy')
local opt_rep = handy.opt_rep
local cho = handy.cho

local un_op = request('expression.un_op')
local vararg = request('words.vararg')
local type_nil = request('type_nil')
local type_boolean = request('type_boolean')
local type_number = request('type_number')
local type_string = request('type_string')
local type_table = request('type_table')
local type_function = request('type_function')
local var_or_call = request('qualifiers.var_or_call')
local bin_op = request('expression.bin_op')

return
  {
    name = 'expression',
    inner_name = 'expression',
    opt_rep(un_op),
    cho(
      vararg,
      type_nil,
      type_boolean,
      type_number,
      type_string,
      type_table,
      type_function,
      var_or_call
    ),
    opt_rep(
      bin_op,
      '>expression'
    )
  }
