-- Deploy given modules with their dependencies

--[[
  Author: Martin Eden
  Last mod.: 2026-09-24
]]

--[[
  Copy files given by pathnamesto deploy directory

  Input
    [t] PathsList -- list of file pathnames
    [?t] Config -- deploy configuration
      [?s] deploy_dir -- deploy directory
      [?b] include_docs -- also locate and copy documentation files

  Output
    None. Performs file operations immediately.
]]

local DefaultConfig = request('get_deploy_plan.DefaultConfig')
local get_deploy_plan = request('!.mechs.get_deploy_plan')
local delete_dir = request('!.file_system.directory.remove')
local copy_file = request('!.file_system.file.copy')

return
  function(PathsList, ArgConfig)
    local Config = new(DefaultConfig, ArgConfig)

    local deploy_dir = Config.deploy_dir

    assert_string(deploy_dir)

    local FilesToCopy = get_deploy_plan(PathsList, Config)

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

--[[
  2026-08-13
  2026-09-24
]]
