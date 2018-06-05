--[[
  Create bash script to deploy given modules with dependencies.

  File created in current directory.
]]

local c_deploy_maker = request('!.mechs.deploy_script_generator.interface')

return
  function(modules, script_name, deploy_dir_name)
    local deploy_maker = new(c_deploy_maker)
    deploy_maker:populate(modules, deploy_dir_name)
    deploy_maker:save_script(script_name)
  end
