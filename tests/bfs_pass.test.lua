package.path = package.path .. ';../?.lua'
require('#base')

local handler
-- handler = request('debug.universal_handler')
handler = request('graph.bfs_pass.handlers').debug_with_indent

local iterator
iterator = request('table.ordered_pass')

local test_table
local table_samples = request('#table_samples')
test_table = table_samples.multitype_table
table_samples.make_table_self_linked(test_table)
table_samples.make_table_folded_self_linked(test_table)


local bfs = request('graph.bfs_pass')

bfs(test_table, 'test_table', handler, iterator)
