-- Reformat string with Lua code

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

-- Imports:
local split_shebang = request('!.concepts.shell.split_shebang')
local get_ast = request('get_ast')
local ast_as_code = request('ast_as_code')

local newline
do
  local AsciiChars = request('!.concepts.Ascii.Chars')
  newline = AsciiChars.newline
end

local reformat =
  function(lua_code_str)
    assert_string(lua_code_str)

    local shebang_str, code_str = split_shebang(lua_code_str)

    local result_str = ast_as_code(get_ast(code_str))

    if shebang_str then
      result_str = shebang_str .. newline .. result_str
    end

    return result_str
  end

-- Export:
return reformat

--[[
  2018
  2026-07-17
  2026-08-08
]]
