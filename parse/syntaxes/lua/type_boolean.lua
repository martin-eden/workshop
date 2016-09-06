local parser = request('^.^.parser')
local handy = parser.handy

local word = request('words.word')

local type_boolean =
  {
    name = 'boolean',
    word(
      handy.cho1('false', 'true')
    ),
  }

return type_boolean
