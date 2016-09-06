package.path = package.path .. ';../?.lua'
require('#base')

local dfs = request('graph.dfs_pass')
local handler
-- handler = request('graph.dfs_pass.printers.debug_with_indent').handler
-- handler = request('debug.universal_handler')
-- handler = request('graph.dfs_pass.printers.nice').handler
handler = request('graph.dfs_pass.printers.lua')

local iterator
iterator = request('table.ordered_pass')

local table_samples = request('tests.#table_samples')
local test_table
-- test_table = _G
-- test_table = table_samples.simple_table
test_table = table_samples.self_linked_table
test_table = table_samples.string_values
test_table = table_samples.numeric_values
-- test_table = table_samples.multitype_table
-- table_samples.make_table_folded_self_linked(test_table)
-- test_table = table_samples

local result = dfs(test_table, 'test_table', handler, iterator)

print(result)
debug_print_flow()
