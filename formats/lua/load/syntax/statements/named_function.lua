local handy = request('!.mechs.processor.handy')

local word = request('^.words.word')
local syntel = request('^.words.syntel')
local name = request('^.words.name')
local function_body = request('function_body')

return
  {
    name = 'named_function',
    word('function'),
    {
      name = 'dot_list',
      handy.list(name, syntel('.')),
    },
    handy.opt(
      {
        name = 'colon_name',
        syntel(':'),
        name
      }
    ),
    function_body,
  }
