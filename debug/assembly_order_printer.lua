local chunk_name = 'assembly_order_printer'

local dfs_printer = request('dfs_printer')

local print_assembly_order_header =
  function(assembly_order_seq)
    print(('assembly_order_seq: (%s)'):format(assembly_order_seq))
  end

local print_assembly_order_footer =
  function()
    print('---')
  end

local print_assembly_order_node =
  function(node)
    print(('  %s'):format(node))
  end

local assembly_order_print =
  function(node_recs, assembly_order_seq)
    dfs_printer.print_node_recs_header(node_recs)
    for i = 1, #assembly_order_seq do
      local node = assembly_order_seq[i]
      dfs_printer.print_node_rec(node, node_recs[node])
    end

    print_assembly_order_header(assembly_order_seq)
    for i = 1, #assembly_order_seq do
      print_assembly_order_node(assembly_order_seq[i])
    end
    print_assembly_order_footer()
  end

tribute(
  chunk_name,
  {
    print = assembly_order_print,
    print_assembly_order_header = print_assembly_order_header,
    print_assembly_order_footer = print_assembly_order_footer,
    print_assembly_order_node = print_assembly_order_node,
  }
)
