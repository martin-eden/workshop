-- Returns name of current directory

--[[
  Status: works
  Version: 1
  Last mod.: 2024-02-11
]]

local GetCurDir_OsCommand = request('!.mechs.cmdline.get_cmd_pwd')()
local ExecuteAndGetOutput = request('!.system.get_program_output_lines')

return
  function()
    local Output = ExecuteAndGetOutput(GetCurDir_OsCommand)

    assert_table(Output)
    assert(#Output == 1)
    assert_string(Output[1])

    return Output[1]
  end
