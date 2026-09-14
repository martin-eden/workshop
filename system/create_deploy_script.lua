-- Create shell script to copy given modules with dependencies

--[[
  Author: Martin Eden
  Last mod.: 2026-09-14
]]

--[[
  Input

    [t] Modules -- list of root Lua modules names (require()-ready)
    [?t] Config -- configuration
      [?s] script_name -- file name of shell script to create
        Default: "deploy.sh"
      [?s] deploy_dir -- deploy directory name
        Default: "deploy/"
      [?b] include_docs -- also deploy documentation files
        Default: true
]]

local get_deploy_script = request('!.mechs.get_deploy_script')
local file_from_str = request('!.convert.file_from_str')

local DefaultConfig =
  {
    script_name = 'deploy.sh',
    deploy_dir = 'deploy',
    include_docs = true,
  }

-- Export:
return
  function(Modules, ArgConfig)
    assert_table(Modules)

    local Config = new(DefaultConfig, ArgConfig)

    local script_filename = Config.script_name
    local deploy_dir = Config.deploy_dir
    local include_docs = Config.include_docs

    assert_string(script_filename)
    assert_string(deploy_dir)
    assert_boolean(include_docs)

    local script =
      get_deploy_script(
        Modules,
        {
          deploy_dir = deploy_dir,
          include_docs = include_docs,
        }
      )

    file_from_str(script_filename, script)
  end

--[[
  2017
  2018
  2026 # #
]]
