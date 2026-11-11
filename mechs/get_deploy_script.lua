-- Generate string with deploy script

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

--[[
  Return string with shell script to copy given files

  Input

    1 [t] -- list of file pathnames
      0+ [s] -- pathname
    2 [?t] -- deploy configuration
      deploy_dir [?s] -- deploy directory
      include_docs [?b] -- also locate and copy documentation files
]]

local get_deploy_plan = request('!.mechs.get_deploy_plan')
local bash_script_writer =
  request('!.concepts.BashScriptWriter.Interface')
local default_config = request('get_deploy_plan.default_config')

return
  function(pathnames, arg_config)
    local config = new(default_config, arg_config)

    local deploy_dir = config.deploy_dir
    assert_string(deploy_dir)

    local script_writer = new(bash_script_writer)

    script_writer:DeleteDir(deploy_dir)

    local copyrecs = get_deploy_plan(pathnames, config)

    for _, rec in ipairs(copyrecs) do
      script_writer:CopyFile(rec[1], rec[2])
    end

    return script_writer:GetScript()
  end

--[[
  2016
  2017 # #
  2018 # # # #
  2026 # # # #
  2026-08-12
]]
