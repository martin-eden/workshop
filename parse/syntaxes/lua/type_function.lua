local parser = request('^.^.parser')
local handy = parser.handy

local word = request('words.word')
local opt_spc = request('words.opt_spc')
local function_body = request('statements.function_body')

local type_function =
  handy.interleave(
    {
      name = 'type_function',
      word('function'),
      function_body,
    },
    opt_spc
  )

return type_function
