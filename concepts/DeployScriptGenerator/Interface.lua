-- Generates Bash script to copy Lua modules and documentation

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

return
  {
    -- [Config]: Include documentation files
    DeployDocs = true,

    -- [Main]
    Populate = request('Populate'),
    SaveScript = request('SaveScript'),

    -- [Internal]
    BashScriptWriter = request('!.concepts.BashScriptWriter.Interface'),
    GetScript = request('GetScript'),
  }

--[[
  2016
  2017 # #
  2018 # # # #
  2026-05-28
]]
