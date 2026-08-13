-- Deploy given modules with their dependencies

--[[
  Author: Martin Eden
  Last mod.: 2026-08-13
]]

--[[
  Copy given modules with their dependencies to deploy directory

  Input
    [t] Modules -- list of Lua module names
    [t] Config -- deploy configuration
      [?s] deploy_dir -- deploy directory
        Default: "deploy/"
      [?b] include_docs -- also locate and copy documentation files
        Default: true

  Output
    None. Performs file operations immediately.
]]

-- Imports:
local get_deploy_plan = request('!.mechs.get_deploy_plan')
local delete_dir = request('!.file_system.directory.remove')
local copy_file = request('!.file_system.file.copy')

local DefaultConfig =
  {
    deploy_dir = 'deploy/',
    include_docs = true,
  }

local deploy =
  function(Modules, ArgConfig)
    local Config = new(DefaultConfig, ArgConfig)

    local deploy_dir = Config.deploy_dir

    assert_string(deploy_dir)

    local FilesToCopy = get_deploy_plan(Modules, Config)

    delete_dir(deploy_dir)

    for _, Rec in ipairs(FilesToCopy) do
      local src_pathname = Rec[1]
      local dest_pathname = Rec[2]

      local is_ok, Result = copy_file(src_pathname, dest_pathname)

      if not is_ok then
        error(Result.error)
      end
    end
  end

-- Export:
return deploy

--[[
  2026-08-13
]]
