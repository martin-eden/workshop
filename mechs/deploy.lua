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

local default_config =
  {
    deploy_dir = 'deploy',
    include_docs = true,
  }
local get_copyrecs = request('deploy.get_copyrecs')
local shell_script_writer = request('!.concepts.shell_script_writer')
local os_tmpname = os.tmpname
local file_from_str = request('!.convert.file_from_str')
local make_file_executable =
  request('!.file_system.file.make_executable')
local execute_file = request('!.concepts.shell.execute')
local remove_file = request('!.file_system.file.remove')

return
  function(paths, arg_config)
    local config = new(default_config, arg_config)

    local deploy_dir = config.deploy_dir
    local include_docs = config.include_docs

    local script_writer = shell_script_writer.create()

    script_writer:delete_dir(deploy_dir)

    local copyrecs = get_copyrecs(paths, deploy_dir, include_docs)

    for _, rec in ipairs(copyrecs) do
      script_writer:copy_file(rec[1], rec[2])
    end

    local script_str = script_writer:get_script()

    local script_name = os_tmpname()
    file_from_str(script_name, script_str)
    make_file_executable(script_name)
    execute_file(script_name)
    remove_file(script_name)
  end

--[[
  2016
  2017 # #
  2018 # # # #
  2026 # # # # #
  2026-11-11
]]
