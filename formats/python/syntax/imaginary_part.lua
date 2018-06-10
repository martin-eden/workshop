--[[
  imagnumber ::=  (floatnumber | digitpart) ("j" | "J")

  -- https://docs.python.org/3/reference/lexical_analysis.html#imaginary-literals
]]

local handy = request('!.mechs.processor.handy')
local cho = handy.cho

local float = request('float')
local dec_digits = request('dec_digits')

return
  {
    cho(float, dec_digits), cho('j', 'J')
  }
