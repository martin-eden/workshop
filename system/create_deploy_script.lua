-- Create bash script to deploy given modules with dependencies

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

--[[
  Input

    [t] Modules -- list of root Lua modules names (require()-ready)
    [?s] script_name -- file name of shell script to create
      Default: "deploy.sh"
    [?s] deploy_dir_name -- directory name for deployed files
      Default: "deploy/"
]]

-- Imports:
local DeployScriptGenerator =
  request('!.concepts.DeployScriptGenerator.Interface')

local create_deploy_script =
  function(Modules, script_name, deploy_dir_name)
    -- Load all modules. This will populate global dependencies table
    for _, module_name in ipairs(Modules) do
      request(module_name)
    end

    -- Deploy maker uses global dependencies table
    local DeployMaker = new(DeployScriptGenerator)
    DeployMaker:Populate(Modules, deploy_dir_name)
    DeployMaker:SaveScript(script_name)
  end

-- Export:
return create_deploy_script

--[[
  2017
  2018
  2026-05-28
  2026-05-29
]]
