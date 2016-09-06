local parser = request('^.^.^.parser')
local handy = parser.handy

local name = request('^.words.name')
local opt_spc = request('^.words.opt_spc')

local prefix_expr =
  {
    handy.cho1(
      name,
      {
        name = 'par_expr',
        '(',
        opt_spc, '>expression',
        opt_spc, ')',
      }
    ),
  }

local comment = request('^.words.comment')
local opt_spc_no_lf =
  {
    handy.opt_rep(handy.cho1(' ', '\t', comment))
  }

local expr_list = request('expr_list')
local type_table = request('^.type_table')
local type_string = request('^.type_string')

local func_args =
  {
    name = 'func_args',
    handy.cho1(
      {
        opt_spc_no_lf, '(',
        opt_spc, handy.opt(expr_list),
        opt_spc, ')',
      },
      {
        opt_spc,
        handy.cho1(type_table, type_string)
      }
    ),
  }

local bracket_expr = request('bracket_expr')

local var_link =
  {
    name = 'var_link',
    prefix_expr,
    handy.opt_rep(
      opt_spc,
      handy.cho1(
        {
          name = 'dot_name',
          '.',
          opt_spc, name
        },
        bracket_expr,
        {
          name = 'colon_name',
          ':',
          opt_spc, name,
          func_args,
        },
        func_args
      )
    ),
  }

return var_link
