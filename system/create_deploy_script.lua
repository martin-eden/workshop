-- Create bash script to deploy given modules with dependencies

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

--[[
  Input

    [t] Modules -- list of root Lua modules names (require()-ready)
    [?t] Options -- settings overrides

      [?s] script_name -- file name of shell script to create
        Default: "deploy.sh"
      [?s] deploy_dir -- deploy directory name
        Default: "deploy/"
      [?b] include_docs -- also deploy documentation files
        Default: true
]]

-- Imports:
local patch_table = request('!.table.patch')
local file_from_str = request('!.convert.file_from_str')
local DeployScriptGenerator =
  request('!.concepts.DeployScriptGenerator.Interface')

local DefaultSettings =
  {
    script_name = 'deploy.sh',
    deploy_dir = 'deploy/',
    include_docs = true,
  }

local create_deploy_script =
  function(Modules, SettingsOverrides)
    assert_table(Modules)

    local Settings = new(DefaultSettings)
    if is_table(SettingsOverrides) then
      patch_table(Settings, SettingsOverrides)
    end

    local script_name = Settings.script_name
    local deploy_dir = Settings.deploy_dir
    local include_docs = Settings.include_docs

    assert_string(script_name)
    assert_string(deploy_dir)
    assert_boolean(include_docs)

    -- Load all modules. This will populate global dependencies table
    for _, module_name in ipairs(Modules) do
      request(module_name)
    end

    -- Deploy maker uses global dependencies table
    local DeployMaker = new(DeployScriptGenerator)
    DeployMaker.include_docs = include_docs
    DeployMaker.deploy_dir = deploy_dir
    local script_str = DeployMaker:GetScript(Modules)

    file_from_str(script_str, script_name)
  end

-- Export:
return create_deploy_script

--[[
  2017
  2018
  2026-05-28
  2026-05-29
]]
