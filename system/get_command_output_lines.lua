-- Execute shell command and return output as list of lines

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local lines_from_str = request('!.convert.lines_from_str')

return
  function(command)
    local is_ok, exec_result = command:execute()

    return lines_from_str(exec_result.output)
  end

--[[
  2017 #
  2024 # #
  2026 # #
]]
