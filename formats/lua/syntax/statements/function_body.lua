local handy = request('!.mechs.processor.handy')
local opt = handy.opt
local cho = handy.cho

local vararg = request('^.words.vararg')
local name_list = request('^.wrappers.name_list')
local syntel = request('^.words.syntel')
local word = request('^.words.word')

return
  {
    {
      name = 'function_params',
      syntel('('),
      opt(
        cho(
          vararg,
          {
            name_list,
            opt(
              syntel(','),
              vararg
            ),
          }
        )
      ),
      syntel(')'),
    },
    {
      '>statements',
      word('end'),
    }
  }
