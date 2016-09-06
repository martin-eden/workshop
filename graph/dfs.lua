-- DFS-pass manager

local new = request('^.handy_mechs.override_params')
local dfs_class = request('dfs.interface')

local dfs_run =
  function(graph, options)
    local dfs = new(dfs_class, options)
    dfs:run(graph)
    local result = dfs.nodes_status
    return result
  end

return dfs_run
