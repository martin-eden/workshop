local parser = request('^.^.^.^.parser')
local handy = parser.handy

local digit_10 = request('digit_10')

local int_10 =
  handy.rep(digit_10)

return int_10
