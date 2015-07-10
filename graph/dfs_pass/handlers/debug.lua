require('#base')

local chunk_name = 'graph.dfs_pass.handlers.debug'

local debug_handle_hook =
  function(visit_type, node, external_name, node_status, depth)
    print(
      ('%s %s %s %s %d'):format(
        visit_type,
        node,
        external_name,
        node_status or '',
        depth
      )
    )
  end

local indent_chunk = '|   '

local debug_handle_hook_with_indent =
  function(visit_type, node, external_name, node_status, depth)
    local result = ''
    result =
      ('%s[%s %s] %s %s'):format(
        string.rep(indent_chunk, depth),
        visit_type,
        external_name,
        node,
        node_status or ''
      )
    print(result)
  end

tribute(
  chunk_name,
  {
    debug = debug_handle_hook,
    debug_indent = debug_handle_hook_with_indent,
  }
)
