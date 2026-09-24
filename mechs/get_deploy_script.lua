-- Generate string with deploy script

--[[
  Author: Martin Eden
  Last mod.: 2026-09-24
]]

--[[
  Return string with shell script to copy given files.

  Input
    [t] PathsList -- list of files pathnames
    [t] Config -- deploy configuration
      [?s] deploy_dir -- deploy directory
      [?b] include_docs -- also locate and copy documentation files
]]

local get_deploy_plan = request('!.mechs.get_deploy_plan')
local BashScriptWriter = request('!.concepts.BashScriptWriter.Interface')
local DefaultConfig = request('get_deploy_plan.DefaultConfig')

return
  function(PathsList, ArgConfig)
    local Config = new(DefaultConfig, ArgConfig)

    local deploy_dir = Config.deploy_dir

    assert_string(deploy_dir)

    local FilesToCopy = get_deploy_plan(PathsList, Config)

    local ScriptWriter = new(BashScriptWriter)

    ScriptWriter:DeleteDir(deploy_dir)

    for _, Rec in ipairs(FilesToCopy) do
      ScriptWriter:CopyFile(Rec[1], Rec[2])
    end

    return ScriptWriter:GetScript()
  end

--[[
  2016
  2017 # #
  2018 # # # #
  2026 # # # #
  2026-08-12
]]
