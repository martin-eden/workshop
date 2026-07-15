-- Compile string with Lua code (may be already compiled bytecode)

--[[
  Author: Martin Eden
  Last mod.: 2026-07-15
]]

-- Imports:
local bytecode_from_function = request('bytecode_from_function')

local compile_source = load

local bytecode_from_source =
  function(source_code_str)
    assert_string(source_code_str)

    local lua_func = compile_source(source_code_str)

    if not lua_func then return end

    return bytecode_from_function(lua_func)
  end

-- Export:
return bytecode_from_source

--[[
  2026-07-15
]]
