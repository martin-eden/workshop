local handy = request('!.mechs.processor.handy')

local vararg = request('^.expressions.vararg')
local name_list = request('^.words.name_list')
local word = request('^.words.word')
local statements = request('statements')
local syntel = request('^.words.syntel')

local params_list =
  handy.cho(
    vararg,
    {
      name_list,
      handy.opt(
        syntel(','),
        vararg
      ),
    }
  )

return
  {
    {
      name = 'function_params',
      syntel('('),
      handy.opt(params_list),
      syntel(')'),
    },
    {
      statements,
      word('end'),
    }
  }
