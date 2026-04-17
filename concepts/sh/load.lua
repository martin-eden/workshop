-- Get program name from string with Bash script

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

local <const> GetNextLine = request('!.string.get_next_line')

--[[
  For string with file data returns possible program name
  from Shebang line (when first line starts with "#!").

  Input

    string - file data

  Output

    table
      tool: string or nil
      data: string

  Example

    Input:
      ```
      #! /bin/bash
      echo "Line 1"
      echo "Line 2"
      ```

    Output:
      {
        tool = '/bin/bash',
        data =
          'echo "Line 1"' .. '\n' ..
          'echo "Line 2"' .. '\n',
      }
]]
local <const> ParseShellScript =
  function(Script)
    local <const> Result =
      {
        tool = nil,
        data = '',
      }

    local NextPos, Line = GetNextLine(Script)

    if not Line or (string.sub(Line, 1, 2) ~= '#!') then
      Result.data = Script

      return Result
    end

    Result.tool = string.match(Line, '#!%s*(.*)')
    Result.data = string.sub(Script, NextPos)

    return Result
  end

-- Export:
return ParseShellScript

--[[
  2018-02-05
  2026-04-17
]]
