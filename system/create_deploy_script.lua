-- Create shell script to copy given modules with dependencies

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
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

-- Imports:
local get_deploy_script =
  request('!.concepts.deploy_script_generator.get_script')
local file_from_str = request('!.convert.file_from_str')

local DefaultConfig =
  {
    script_name = 'deploy.sh',
    deploy_dir = 'deploy/',
    include_docs = true,
  }

local create_deploy_script =
  function(Modules, ArgConfig)
    assert_table(Modules)

    local Config = new(DefaultConfig, ArgConfig)

    local script_name = Config.script_name
    local deploy_dir = Config.deploy_dir
    local include_docs = Config.include_docs

    assert_string(script_name)
    assert_string(deploy_dir)
    assert_boolean(include_docs)

    -- Load all modules. This will populate global dependencies table
    for _, module_name in ipairs(Modules) do
      request(module_name)
    end

    -- Deploy script generator uses global dependencies table

    local script_str
    do
      local Config =
        {
          deploy_dir = deploy_dir,
          include_docs = include_docs,
        }
      script_str = get_deploy_script(Modules, Config)
    end

    file_from_str(script_str, script_name)
  end

-- Export:
return create_deploy_script

--[[
  2017
  2018
  2026-05 ##
]]
