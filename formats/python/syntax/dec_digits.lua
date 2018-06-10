local handy = request('!.mechs.processor.handy')
local opt = handy.opt
local opt_rep = handy.opt_rep

local dec_digit =
  match_regexp('[0123456789]')

return
  {
    dec_digit,
    opt_rep(opt('_'), dec_digit)
  }
