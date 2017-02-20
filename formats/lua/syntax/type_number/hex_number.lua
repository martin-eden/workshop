local parser = request('^.^.^.^.mechs.parser')
local handy = parser.handy

local int_16 = request('hex_number.int_16')
local frac_point = request('frac_point')

local hex_base =
  {
    '0',
    handy.cho('x', 'X'),
    handy.cho(
      {
        frac_point,
        int_16,
      },
      {
        int_16,
        handy.opt(
          frac_point,
          handy.opt(int_16)
        )
      }
    )
  }

local exp_sign = request('exp_sign')
local int_10 = request('dec_number.int_10')

local bin_power =
  {
    handy.cho('p', 'P'),
    handy.opt(exp_sign),
    int_10
  }

return
  {
    hex_base,
    handy.opt(bin_power)
  }
