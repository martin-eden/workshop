-- Prepare configuration for run

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

-- Imports:
local strip_lua_postfix = request('strip_lua_postfix')
local get_modules_dependencies = request('!.system.get_modules_dependencies')
local add_to_list = request('!.concepts.list.add_item')
local get_module_location = request('!.system.get_module_location')

local augment_config =
  function(Config)
    assert_string(Config.project_name)
    assert_string(Config.short_desc)
    assert_string(Config.description)
    assert_string(Config.license)
    assert_table(Config.repository)
    assert_string(Config.repository.url)
    assert_string(Config.repository.branch)

    Config.rockspec_name = ('%s-scm-1.rockspec'):format(Config.project_name)

    assert_table(Config.used_modules)

    if Config.commands then
      assert_table(Config.commands)
      for _, Command in ipairs(Config.commands) do
        assert_string(Command.command)
        assert_string(Command.wrapper)
        assert_string(Command.lua_script)
        Command.lua_script = strip_lua_postfix(Command.lua_script)
      end
    end

    local UsedModules = get_modules_dependencies(Config.used_modules)

    if Config.commands then
      for _, Command in ipairs(Config.commands) do
        add_to_list(UsedModules, Command.lua_script)
      end
    end

    local UsedFiles = { }

    for _, module_name in ipairs(UsedModules) do
      add_to_list(UsedFiles, get_module_location(module_name))
    end

    table.sort(UsedFiles)

    Config.used_files = UsedFiles
  end

-- Export:
return augment_config

--[[
  2016?
  2018 # # # #
  2026-05-29
]]
