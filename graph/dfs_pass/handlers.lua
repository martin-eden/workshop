require('#base')

local chunk_name = 'graph.dfs_pass.handlers'

tribute(
  chunk_name,
  {
    debug = request('graph.dfs_pass.handlers.debug').debug,
    debug_with_indent = request('graph.dfs_pass.handlers.debug').debug_indent,
    nice_print = request('graph.dfs_pass.handlers.nice_print').handler,
  }
)
