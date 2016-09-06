package.path = package.path .. ';../?.lua'
require('#base')

local assembly_order = request('graph.assembly_order')
local assembly_order_print = request('debug.assembly_order_printer').print

local dfs_options = {also_visit_keys = true}
local test_tables = request('tests.#table_samples')
local test_table
-- test_table = test_tables.self_linked_table
test_table = _G

assembly_order_print(assembly_order(test_table, dfs_options))
-- assembly_order_print(assembly_order(test_tables.lua_print_test_3, dfs_options))
-- assembly_order_print(assembly_order(test_tables.lua_print_test_2, dfs_options))
-- assembly_order_print(assembly_order(test_tables.lua_print_test_1, dfs_options))
-- assembly_order_print(assembly_order(test_tables.lua_print_cross_linked, dfs_options))
-- assembly_order_print(assembly_order(test_tables.lua_print_self_linked, dfs_options))
