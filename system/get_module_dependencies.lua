--[[
  Return list of modules required by given module.

  If root module is not loaded - it's loaded.
  List always contains root module.
]]

--[[
  _G.dependencies structure is rep(key: string, value: true | @)

  This function treats string keys as children of node.

  Worth exporting as standalone but do not see name for it's place.
]]
local get_children
do
  local get_keys = request('!.table.get_keys')
  local get_key_vals = request('!.table.get_key_vals')

  get_children =
    function(self, node)
      node = _G.dependencies[node] or {}
      local result
      result = get_key_vals(get_keys(node))
      return result
    end
end

local dfs = request('!.mechs.graph.dfs')

return
  function(module_name)
    assert_string(module_name)
    assert_table(_G.dependencies)

    local require_module_name = get_require_name(module_name)

    if not _G.dependencies[require_module_name] then
      request(module_name)
    end

    local result = {}

    local on_visit =
      function(node, node_rec, deep)
        result[#result + 1] = node
      end

    dfs(
      require_module_name,
      {
        handle_discovery = on_visit,
        get_children = get_children,
      }
    )

    return result
  end
