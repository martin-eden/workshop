-- Execute shell command and return output as list of lines

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Imports:
local shell_execute = request('!.concepts.shell.execute')
local lines_from_str = request('!.convert.lines_from_str')

local get_program_output_lines =
  --[[
    Execute shell command in given string.
    Return command output as list of lines.
  ]]
  function(shell_cmd)
    assert_string(shell_cmd)

    local ExecResult = shell_execute(shell_cmd)

    return lines_from_str(ExecResult.Output)
  end

-- Export:
return get_program_output_lines

--[[
  2017 #
  2024 # #
  2026-04-22
]]
