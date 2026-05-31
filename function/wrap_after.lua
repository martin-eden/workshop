-- Wrap function call with function called after

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

-- Imports:
local wrap_func = request('wrap')

local wrap_after =
  function(func, Args, func_after)
    return wrap(func, Args, nil, func_after)
  end

-- Export:
return wrap_after

--[[
  2026-05-31
]]
