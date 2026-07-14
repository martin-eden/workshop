-- Compile chunk of Lua code (usually function)

--[[
  Author: Martin Eden
  Last mod.: 2026-07-13
]]

local get_func_code = string.dump

local compile =
  function(lua_func)
    local strip = true

    return get_func_code(lua_func, strip)
  end

-- Export:
return compile

--[[
  2026-07-13
]]
