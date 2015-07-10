require('#test_loader')

local dfs = request('graph.dfs_pass')
local handlers = request('graph.dfs_pass.handlers')
dfs(_G, '_G', handlers.nice_print)
