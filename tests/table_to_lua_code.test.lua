package.path = package.path .. ';../?.lua'
require('#base')

local get_lua_code = request('save_to.table_to_lua_code')

local table_samples = request('tests.#table_samples')
local test_table
-- test_table = table_samples.self_linked_table
-- test_table = table_samples.lua_print_test_4
test_table = _G

local result = get_lua_code(test_table)
print(result)

-- debug_print_flow()
