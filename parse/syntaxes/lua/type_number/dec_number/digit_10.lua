local parser = request('^.^.^.^.parser')
local handy = parser.handy

local digit_10 =
  handy.cho1('0', '1', '2', '3', '4', '5', '6', '7', '8', '9')

return digit_10
