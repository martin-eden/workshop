local parser = request('^.^.^.^.parser')
local handy = parser.handy

local digit_16 = request('digit_16')

local int_16 =
  handy.rep(digit_16)

return int_16
