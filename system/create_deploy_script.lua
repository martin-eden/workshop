--[[
  Create bash script to deploy given modules with dependencies.

  File created in current directory.
]]

local deploy_maker = request('!.mechs.deploy_script.interface')

return
  function(modules, script_name, deploy_dir_name)
    deploy_maker.save_script(modules, script_name, deploy_dir_name)
  end
