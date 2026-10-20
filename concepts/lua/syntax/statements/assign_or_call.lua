-- Grammar for "assign or call"

--[[
  Author: Martin Eden
  Last mod.: 2026-10-25
]]

local handy = request('!.mechs.processor.handy')
local opt = handy.opt
local opt_rep = handy.opt_rep

local syntel = request('^.words.syntel')
local expr_list = request('^.wrappers.expr_list')
local var_or_call = request('^.qualifiers.var_or_call')

return
  {
    name = 'assign_or_call',
    var_or_call,
    opt(
      opt_rep(syntel(','), var_or_call),
      syntel('='),
      expr_list
    ),
  }

--[[
  2018 #
  2026-10-25
]]
