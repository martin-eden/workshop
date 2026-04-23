-- Parse string with Lua code to AST table

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

-- Imports:
local Lines = request('!.concepts.Lines')
local LuaSyntax = request('!.concepts.lua.syntax')
local Parse = request('!.mechs.generic_loader')

local IsShebang =
  function(Str)
    return (string.sub(Str, 1, 2) == '#!')
  end

-- Extract program name from #! shebang string
local GetProgramName =
  function(Str)
    return string.match(Str, '#!%s*(.*)')
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

    local CodeLines = new(Lines)

    CodeLines:FromString(CodeStr)

    local FirstLine = CodeLines:GetFirstLine()

    local ShebangStr
    if IsShebang(FirstLine) then
      ShebangStr = '#! ' .. GetProgramName(FirstLine)
      CodeLines:RemoveFirstLine()
    end

    CodeStr = CodeLines:ToString()

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
]]
