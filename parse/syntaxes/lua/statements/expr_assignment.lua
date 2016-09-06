local parser = request('^.^.^.parser')
local handy = parser.handy

local var_link = request('^.expressions.var_link')
local opt_spc = request('^.words.opt_spc')
local expr_list = request('^.expressions.expr_list')

local var_list =
  {
    name = 'var_list',
    handy.list({opt_spc, var_link}, {opt_spc, ','}),
  }

local expr_assignment =
  {
    name = 'execute_assign',
    var_list,
    {
      name = 'source',
      handy.opt(
        opt_spc, '=',
        opt_spc, expr_list
      ),
    }
  }

return expr_assignment
