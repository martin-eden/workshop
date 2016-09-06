local chunk_name = 'print_table'

local dfs = request('^.graph.dfs_pass')

local handler = request('^.graph.dfs_pass.handlers').nice_print
-- local handler = request('dfs_pass.handlers').debug_with_indent
-- local handler = request('dfs_pass.handlers').debug
--[[
local handler_object = request('dfs_pass.handlers.nice_print')
handler_object.set_options({indent_chunk = '|-'})
local handler = handler_object.handler
]]

local iterator = request('^.table.default_ordered_pass')

local print_table =
  function(graph, graph_name)
  	local graph_name = graph_name or '*'
    assert_table(graph)
    assert_string(graph_name)
  	dfs(graph, graph_name, handler, iterator)
  end

tribute(chunk_name, print_table)
