local handy = request('!.mechs.processor.handy')

local word = request('^.words.word')
local syntel = request('^.words.syntel')
local name_list = request('^.words.name_list')
local expr_list = request('^.expressions.expr_list')
local named_function = request('named_function')

return
  {
    name = 'local_statement',
    word('local'),
    handy.cho(
      {
        name = 'local_assignment',
        name_list,
        handy.opt(
          syntel('='),
          expr_list
        )
      },
      named_function
    ),
  }
