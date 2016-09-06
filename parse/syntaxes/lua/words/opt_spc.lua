local parser = request('^.^.^.parser')
local handy = parser.handy

local comment = request('comment')

local opt_spc =
  handy.opt_rep(
    handy.cho1(
      handy.match_pattern('[ \t\n\r]+'),
      comment
    )
  )

return opt_spc
