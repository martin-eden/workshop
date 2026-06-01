-- Returns sorted list of filenames for used modules

--[[
  Author: Martin Eden
  Last mod.: 2026-06-01
]]

--[[
  Uses _G.package.loaded to get list of module names.

  We'll search in that list and return found files.
]]

-- Imports:
local get_table_keys = request('!.table.get_keys')
local get_module_pathname = request('get_module_pathname')
local add_to_list = request('!.concepts.list.add_item')

local get_loaded_modules_files =
  function()
    local ModulesPathnames = { }

    local ModulesNames = get_table_keys(_G.package.loaded)

    for _, module_name in ipairs(ModulesNames) do
      add_to_list(ModulesPathnames, get_module_pathname(module_name))
    end

    table.sort(ModulesPathnames)

    return ModulesPathnames
  end

-- Export:
return get_loaded_modules_files

--[[
  2017
  2026-06-01
]]
