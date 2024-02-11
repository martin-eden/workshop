--[[
  Execute shell command from given string.
  Return text output as table with a sequence of lines.

  (cmd:string) -> { ...:string }
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

--[[
  2017-08-11
  2024-02-11 Documentation change
]]
