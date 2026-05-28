-- Create bash script to deploy given modules with dependencies

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
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
local DeployScriptGenerator = request('!.mechs.deploy_script_generator.interface')

local create_deploy_script =
  function(Modules, script_name, deploy_dir_name)
    local DeployMaker = new(DeployScriptGenerator)

    DeployMaker:populate(Modules, deploy_dir_name)

    DeployMaker:save_script(script_name)
  end

-- Export:
return create_deploy_script

--[[
  2017
  2018
  2026-05-28
]]
