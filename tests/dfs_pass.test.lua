package.path = package.path .. ';../?.lua'
require('#base')

local dfs = request('graph.dfs_pass')
local handler
-- handler = request('graph.dfs_pass.handlers').debug_with_indent
-- handler = request('debug.universal_handler')
handler = request('graph.dfs_pass.handlers').nice_print

local iterator
iterator = request('table.default_ordered_pass')

local table_samples = request('tests.#table_samples')
local test_table
test_table = _G
-- test_table = table_samples.multitype_table
-- table_samples.make_table_folded_self_linked(test_table)
-- test_table = table_samples

dfs(test_table, 'test_table', handler, iterator)
