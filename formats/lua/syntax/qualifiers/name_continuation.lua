--[[
  Possible reference qualifiers.

  :

    ---+- <bracket_expr> +---
       +- <dot_name> ----+

  This module is standalone because it's used in [function_call] and
  [var_ref].
]]

local handy = request('!.mechs.processor.handy')
local cho = handy.cho

local bracket_expr = request('^.wrappers.bracket_expr')
local dot_name = request('^.wrappers.dot_name')

return cho(bracket_expr, dot_name)
