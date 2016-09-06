local parser = request('^.^.^.parser')
local handy = parser.handy

local vararg = request('^.expressions.vararg')
local name_list = request('^.words.name_list')
local word = request('^.words.word')
local statements = request('statements')
local opt_spc = request('^.words.opt_spc')

local params_list =
  {
    handy.cho1(
      vararg,
      {
        name_list,
        handy.opt(
          opt_spc, ',',
          opt_spc, vararg
        )
      }
    )
  }

local function_body =
  {
    {
      name = 'function_params',
      '(',
      opt_spc, handy.opt(params_list),
      opt_spc, ')',
    },
    {
      name = 'function_body',
      opt_spc, statements,
      opt_spc, word('end'),
    }
  }

return function_body
