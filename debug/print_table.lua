local chunk_name = 'print_table'

local dfs = request('^.graph.dfs_pass')

local printer = request('^.graph.dfs_pass.printers.nice')
-- local handler = request('dfs_pass.printers').debug_with_indent
-- local handler = request('dfs_pass.printers').debug
--[[
local handler_object = request('dfs_pass.printers.nice')
handler_object.set_options({indent_chunk = '|-'})
]]
local handler = printer.handler

local iterator = request('^.table.ordered_pass')

local print_table =
  function(graph, graph_name)
  	local graph_name = graph_name or '*'
    assert_table(graph)
    assert_string(graph_name)
  	dfs(graph, graph_name, handler, iterator)
  end

tribute(chunk_name, print_table)
