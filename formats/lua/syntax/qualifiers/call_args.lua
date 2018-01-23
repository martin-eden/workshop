--[[
  Function call arguments.

  :

    ---+----------------+--- <func_args> ---
       +- <colon_name> -+

  This module is standalone because it's used in [var_ref] and
  [function_call].
]]

local handy = request('!.mechs.processor.handy')
local opt = handy.opt

local colon_name = request('^.wrappers.colon_name')
local func_args = request('^.qualifiers.func_args')

return {opt(colon_name), func_args}
