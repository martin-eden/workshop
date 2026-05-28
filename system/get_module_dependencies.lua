-- Return list of modules required by given module

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

--[[
  List always contains root module.
]]

-- Imports:
local dfs = request('!.mechs.graph.dfs')
local get_keys = request('!.table.get_keys')
local get_key_vals = request('!.table.get_key_vals')
local add_to_list = request('!.concepts.list.add_item')

local Dependencies_Map = get_dependencies()

--[[
  Dependencies table is map:

    ((a -> b) (b -> c) ( a -> d))
    ->
    {
      ['a'] = { ['b'] = true, ['d'] = true },
      ['b'] = { ['c'] = true },
    }
]]

local get_children =
  function(self, node)
    return get_key_vals(get_keys(Dependencies_Map[node] or { }))
  end

local get_module_dependencies =
  function(module_name)
    assert_string(module_name)

    local require_module_name = get_require_name(module_name)

    local Result = { }

    dfs(
      require_module_name,
      {
        handle_discovery = function(Node) add_to_list(Result, Node) end,
        get_children = get_children,
      }
    )

    return Result
  end

-- Export:
return get_module_dependencies

--[[
  2018
  2026-05-28
]]
