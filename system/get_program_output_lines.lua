--[[
  Execute shell command from given string.
  Return text output as a sequence of lines.

  Input: <command>
  Output: <sequence of strings>
]]

return
  function(cmd)
    assert_string(cmd)
    local result = {}
    local result_file = io.popen(cmd, 'r')
    for line in result_file:lines() do
      result[#result + 1] = line
    end
    result_file:close()
    return result
  end
