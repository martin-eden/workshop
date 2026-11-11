-- Deploy given modules with their dependencies

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

--[[
  Copy files given by pathnames to deploy directory

  Input

    1 [t] -- list of file pathnames
      0+ [s] -- pathname
    2 [?t] -- deploy configuration
      deploy_dir [?s] -- deploy directory
      include_docs [?b] -- also locate and copy documentation files
]]

local default_config = request('get_deploy_plan.default_config')
local get_deploy_plan = request('!.mechs.get_deploy_plan')
local delete_dir = request('!.file_system.directory.remove')
local copy_file = request('!.file_system.file.copy')

return
  function(paths, arg_config)
    local config = new(default_config, arg_config)

    local deploy_dir = config.deploy_dir
    assert_string(deploy_dir)

    local copyrecs = get_deploy_plan(paths, config)

    delete_dir(deploy_dir)

    for _, rec in ipairs(copyrecs) do
      local is_ok, result = copy_file(rec[1], rec[2])
      if not is_ok then
        error(result.error)
      end
    end
  end

--[[
  2026 # #
]]
