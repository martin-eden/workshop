local handy = request('!.mechs.processor.handy')

local name = request('^.words.name')
local syntel = request('^.words.syntel')

local expr_list = request('expr_list')
local type_table = request('^.type_table')
local type_string = request('^.type_string')

local func_args =
  {
    name = 'func_args',
    handy.cho(
      {
        syntel('('),
        handy.opt(expr_list),
        syntel(')'),
      },
      type_table,
      type_string
    ),
  }

local par_expr =
  {
    name = 'par_expr',
    syntel('('),
    '>expression',
    syntel(')'),
  }

local dot_name =
  {
    name = 'dot_name',
    syntel('.'),
    name
  }

local colon_name =
  {
    name = 'colon_name',
    syntel(':'),
    name,
  }

local bracket_expr = request('bracket_expr')

return
  {
    name = 'var_link',
    handy.cho(
      name,
      par_expr
    ),
    handy.opt_rep(
      handy.cho(
        dot_name,
        bracket_expr,
        {colon_name, func_args},
        func_args
      )
    ),
  }
