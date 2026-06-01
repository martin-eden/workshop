-- Get source code files list for list of module names

--[[
  Author: Martin Eden
  Last mod.: 2026-06-01
]]

--[[
  Input

    [t] Modules -- strings list with Lua root module names
]]

-- Imports:
local get_modules_dependencies = request('!.system.get_modules_dependencies')
local get_module_pathname = request('!.system.get_module_pathname')
local add_to_list = request('!.concepts.list.add_item')

local get_modules_filelist =
  function(Modules)
    local Result = { }

    local ModulesRequired = get_modules_dependencies(Modules)

    for _, module_name in ipairs(ModulesRequired) do
      local module_pathname = get_module_pathname(module_name)

      add_to_list(Result, module_pathname)
    end

    return Result
  end

-- Export:
return get_modules_filelist

--[[
  2018
  2026-05-28
  2026-05-29
]]
