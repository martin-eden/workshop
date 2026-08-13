-- Return list of modules required for given list of modules

--[[
  Author: Martin Eden
  Last mod.: 2026-08-13
]]

--[[
  Input

    [t] Modules -- list of root modules names

  Output

    [t] -- List of all required modules

  So if module "a" requires "lib" and module "b" requires it,
  result of call ({'a', 'b'}) will be ({'a', 'b', 'lib'}).
]]

-- Imports:
local get_module_dependencies = request('get_module_dependencies')
local add_to_list = request('!.concepts.list.add_item')

local get_modules_dependencies =
  function(Modules)
    assert_table(Modules)

    local Result = { }
    do
      local UsedModules_Map = { }

      for _, root_module_name in ipairs(Modules) do
        local ModuleDependencies = get_module_dependencies(root_module_name)

        for _, module_name in ipairs(ModuleDependencies) do
          if not UsedModules_Map[module_name] then
            UsedModules_Map[module_name] = true

            add_to_list(Result, module_name)
          end
        end
      end
    end

    return Result
  end

-- Export:
return get_modules_dependencies

--[[
  2018 #
  2024 #
  2026-05-29
]]
