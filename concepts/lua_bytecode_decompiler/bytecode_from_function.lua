-- Compile chunk of Lua code (usually function) to string with bytecode

--[[
  Author: Martin Eden
  Last mod.: 2026-10-19
]]

local str_dump = string.dump
local strip = true

return
  function(lua_func)
    return str_dump(lua_func, strip)
  end

--[[
  2026-07-13
]]
