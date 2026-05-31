-- Wrap function call with function called before

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

-- Imports:
local wrap_func = request('wrap')

local wrap_before =
  function(func, Args, func_before)
    return wrap(func, Args, func_before)
  end

-- Export:
return wrap_before

--[[
  2026-05-31
]]
