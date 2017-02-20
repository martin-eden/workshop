local parser = request('^.^.^.^.^.mechs.parser')
local handy = parser.handy

local digit_10 = request('^.dec_number.digit_10')

return
  handy.cho(
    digit_10,
    'a', 'b', 'c', 'd', 'e', 'f',
    'A', 'B', 'C', 'D', 'E', 'F'
  )
