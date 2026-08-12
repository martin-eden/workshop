-- Execute shell command and return output as list of lines

--[[
  Author: Martin Eden
  Last mod.: 2026-08-12
]]

-- Imports:
local lines_from_str = request('!.convert.lines_from_str')

local get_program_output_lines =
  function(Command)
    local is_ok, ExecResult = Command:Execute()

    return lines_from_str(ExecResult.output)
  end

-- Export:
return get_program_output_lines

--[[
  2017 #
  2024 # #
  2026 #
  2026-08-12
]]
