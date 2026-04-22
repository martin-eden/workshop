-- Execute shell command and return output as list of lines

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

local shell_execute = request('!.concepts.shell.execute')
local string_to_lines = request('!.string.to_lines')

local get_program_output_lines =
  --[[
    Execute shell command in given string.
    Return command output as list of lines.
  ]]
  function(shell_cmd)
    assert_string(shell_cmd)

    local ExecResult = shell_execute(shell_cmd)

    local Lines = string_to_lines(ExecResult.Output)

    return Lines
  end

-- Export:
return get_program_output_lines

--[[
  2017 #
  2024 # #
  2026-04-22
]]
