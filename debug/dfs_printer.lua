local chunk_name = 'dfs_printer'

local print_handler_params =
  function(event_name, node, node_rec, deep)
    print(
      event_name,
      node,
      node_rec.color,
      node_rec.discovery_time,
      node_rec.finish_time,
      deep
    )
  end

local print_node_recs_header =
  function(node_recs)
    print(('node_recs: (%s)'):format(node_recs))
  end

local print_node_rec =
  function(node, node_rec)
    print(
      (
        '  node: %s\n' ..
        '    color: %s\n' ..
        '    discovery_time: %s\n' ..
        '    finish_time: %s\n' ..
        '    parent: %s\n' ..
        '    parent_key: %s'
      ):format(
        node,
        node_rec.color,
        node_rec.discovery_time,
        node_rec.finish_time,
        node_rec.parent,
        node_rec.parent_key
      )
    )
    if node_rec.refs then
      print('    refs:')
      for parent, parent_keys in pairs(node_rec.refs) do
        print(('      %s'):format(parent))
        for parent_key in pairs(parent_keys) do
          print(('        [%s]'):format(parent_key))
        end
      end
    end
  end

local dfs_print =
  function(node_recs)
    print_node_recs_header(node_recs)
    for k, v in pairs(node_recs) do
      print_node_rec(k, v)
    end
  end

tribute(
  chunk_name,
  {
    print_handler_params = print_handler_params,

    print = dfs_print,
    print_node_recs_header = print_node_recs_header,
    print_node_rec = print_node_rec,
  }
)
