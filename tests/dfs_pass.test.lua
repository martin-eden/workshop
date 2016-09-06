<<<<<<< HEAD
package.path = package.path .. ';../?.lua'
require('#base')

local dfs = request('graph.dfs')
local dfs_printer = request('debug.dfs_printer')
local dfs_print = dfs_printer.print

local dfs_options = {also_visit_keys = true, handler = dfs_printer.print_handler_params}
local test_tables = request('tests.#table_samples')
local test_table
-- test_table = test_tables.self_linked_table
-- test_table = test_tables.lua_print_test_4
test_table = _G

dfs_print(dfs(test_table, dfs_options))
=======
package.path = package.path .. ';../?.lua'
require('#base')

local dfs = request('graph.dfs')
local dfs_printer = request('debug.dfs_printer')
local dfs_print = dfs_printer.print

local dfs_options = {also_visit_keys = true, handler = dfs_printer.print_handler_params}
local test_tables = request('tests.#table_samples')
local test_table
-- test_table = test_tables.self_linked_table
test_table = test_tables.lua_print_test_3
-- test_table = _G

dfs_print(dfs(test_table, dfs_options))
>>>>>>> 5797df5... [-*] Existing tests actualised with code.
