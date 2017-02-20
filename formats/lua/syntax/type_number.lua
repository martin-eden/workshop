local parser = request('^.^.^.mechs.parser')
local handy = parser.handy

local dec_number = request('type_number.dec_number')
local hex_number = request('type_number.hex_number')

return
  {
    name = 'number',
    handy.cho(hex_number, dec_number)
  }
