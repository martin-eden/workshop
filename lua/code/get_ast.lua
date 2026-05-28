-- Parse string with Lua code to AST table

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

-- Imports:
local lines_from_str = request('!.convert.lines_from_str')
local add_to_list = request('!.concepts.list.add_item')
local lines_to_str = request('!.convert.lines_to_str')
local Syntax = request('!.concepts.lua.syntax')
local generic_loader = request('!.mechs.generic_loader')

local is_shebang =
  function(str)
    return (string.sub(str, 1, 2) == '#!')
  end

--[[
  Parse string with Lua code to AST table

  Handles possible shebang line ("#!") at the start of data.

  Returns table:

    Table returned from parsing with added fields:

      [?s] shebang_str -- Shebang line
      [?s] unparsed_tail -- Unparsed data at the end
]]
local get_ast =
  function(code_str)
    assert_string(code_str)

    local CodeLines = lines_from_str(code_str)

    local shebang_str
    do
      local first_line = CodeLines[1]

      if is_shebang(first_line) then
        shebang_str = first_line
        table.remove(CodeLines, 1)
        code_str = lines_to_str(CodeLines)
      end
    end

    local Result, unparsed_tail = generic_loader(code_str, Syntax)

    Result = Result or { }
    Result.shebang_str = shebang_str
    Result.unparsed_tail = unparsed_tail

    return Result
  end

-- Export:
return get_ast

--[[
  2018-02-05
  2026-04-17
  2026-05-28
]]
