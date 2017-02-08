local parser = request('^.^.^.^.^.mechs.parser')
local handy = parser.handy

local digit_10 = request('digit_10')

return handy.rep(digit_10)
