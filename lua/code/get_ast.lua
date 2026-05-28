-- Parse string with Lua code to AST table

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

-- Imports:
local lines_from_str = request('!.convert.lines_from_str')
local add_to_list = request('!.concepts.list.add_item')
local lines_to_str = request('!.convert.lines_to_str')
local LuaSyntax = request('!.concepts.lua.syntax')
local Parse = request('!.mechs.generic_loader')

local IsShebang =
  function(Str)
    return (string.sub(Str, 1, 2) == '#!')
  end

--[[
  Parse string with Lua code to AST table

  Handles possible shebang line ("#!") at the start of data.

  Returns table:

    Table returned from parsing with added fields:

    .shebang_str -- [] Optional shebang line
    .unparsed_tail -- [] Optional unparsed data at the end
    }
]]
local GetAst =
  function(CodeStr)
    assert_string(CodeStr)

    local CodeLines = lines_from_str(CodeStr)

    local FirstLine = CodeLines[1]

    local ShebangStr
    if IsShebang(FirstLine) then
      ShebangStr = FirstLine
      table.remove(CodeLines, 1)
    end

    CodeStr = lines_to_str(CodeLines)

    local Result, UnparsedTail = Parse(CodeStr, LuaSyntax)

    Result = Result or {}
    Result.shebang_str = ShebangStr
    Result.unparsed_tail = UnparsedTail

    return Result
  end

-- Export:
return GetAst

--[[
  2018-02-05
  2026-04-17
  2026-05-28
]]
