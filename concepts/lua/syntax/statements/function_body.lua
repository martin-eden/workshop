-- Function body grammar (params and statements)

--[[
  Author: Martin Eden
  Last mod.: 2026-10-25
]]

--[[
               function_params
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ─ ( ─┬───────────────────────────────┬─ ) ─ statements ─ word(end) ─
       ├─ vararg ──────────────────────┤
       └─ name_list ─┬──────────────┬──┘
                     └─ , ─ vararg ─┘
]]

local handy = request('!.mechs.processor.handy')
local opt = handy.opt
local cho = handy.cho

local vararg = request('^.words.vararg')
local name_list = request('^.wrappers.name_list')

return
  {
    {
      name = 'function_params',
      '(',
      opt(
        cho(
          vararg,
          { name_list, opt(',', vararg) }
        )
      ),
      ')',
    },
    '>statements',
    'end',
  }

--[[
  2016 # #
  2018 #
  2026-10-25
]]
