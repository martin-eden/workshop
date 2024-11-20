--[[
  Execute shell command in given string.
  Return command output as list of lines.
]]

-- Last mod.: 2024-11-20

local StringToLines = request('!.string.to_lines')

return
  function(Command)
    assert_string(Command)
    local OutputPipe = io.popen(Command, 'r')
    local OutputText = OutputPipe:read('a')
    OutputPipe:close()

    local Result = StringToLines(OutputText)

    return Result
  end

--[[
  2017-08-11
  2024-02-11 Documentation change
  2024-11-20
]]
