-- Compile chunk of Lua code (usually function) to string with bytecode

--[[
  Author: Martin Eden
  Last mod.: 2026-07-13
]]

local get_func_code = string.dump

local strip = true

local bytecode_from_function =
  function(lua_func)
    assert_function(lua_func)

    return get_func_code(lua_func, strip)
  end

-- Export:
return bytecode_from_function

--[[
  2026-07-13
]]
