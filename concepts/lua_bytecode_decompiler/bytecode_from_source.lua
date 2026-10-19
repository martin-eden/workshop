-- Compile string with Lua code (may be already compiled bytecode)

--[[
  Author: Martin Eden
  Last mod.: 2026-10-19
]]

local split_shebang = request('!.concepts.shell.split_shebang')
local g_load = _G.load
local bytecode_from_function = request('bytecode_from_function')

return
  function(source_code_str)
    local shebang_str, source_code_str = split_shebang(source_code_str)
    local lua_func = g_load(source_code_str)
    if not lua_func then return end
    return bytecode_from_function(lua_func)
  end

--[[
  2026 # #
]]
