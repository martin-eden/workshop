-- Parse string with Lua code to AST table

--[[
  Author: Martin Eden
  Last mod.: 2026-07-17
]]

--[[
  Parse string with Lua code to AST table

  Returns table:

    Table returned from parsing with added fields:

      [?s] unparsed_tail -- Unparsed data at the end
]]

-- Imports:
local Syntax = request('!.concepts.lua.syntax')
local generic_loader = request('!.mechs.generic_loader')

local get_ast =
  function(code_str)
    assert_string(code_str)

    local Result, unparsed_tail = generic_loader(code_str, Syntax)

    Result = Result or { }
    Result.unparsed_tail = unparsed_tail

    return Result
  end

-- Export:
return get_ast

--[[
  2018
  2026 # #
  2026-07-17
]]
