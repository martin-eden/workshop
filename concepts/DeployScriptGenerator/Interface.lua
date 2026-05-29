-- Generates Bash script to copy Lua modules and documentation

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

return
  {
    -- [Config]
    deploy_dir = 'deploy/',
    include_docs = true,

    -- [Main]
    GetScript = request('GetScript'),

    -- [Internal]
    FilesRequired = { },
  }

--[[
  2016
  2017 # #
  2018 # # # #
  2026-05-28
]]
