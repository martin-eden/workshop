<<<<<<< HEAD:tests/copy_table.test.lua
package.path = package.path .. ';../?.lua'
require('#base')

local copy_table = request('^.table.clone')
local print_table = request('^.debug.print_table')
local sample_tables = request('^.tests.#table_samples')

local test_table
test_table = sample_tables.multitype_table
-- test_table = {}
sample_tables.make_table_self_linked(test_table)
sample_tables.make_table_folded_self_linked(test_table)
-- test_table = _G

print('---original---')
print_table(test_table)
print('---clone---')
print_table(copy_table(test_table))
=======
package.path = package.path .. ';../?.lua'
require('#base')

local clone_table = request('^.table.clone')
local get_table_str = request('^.save_to.table_to_lua_code')
local sample_tables = request('^.tests.#table_samples')

local test_table
test_table = sample_tables.multitype_table
-- test_table = {}
sample_tables.make_table_self_linked(test_table)
sample_tables.make_table_folded_self_linked(test_table)
-- test_table = _G

print('---original---')
print(get_table_str(test_table))
print('---clone---')
print(get_table_str(clone_table(test_table)))
>>>>>>> 5797df5... [-*] Existing tests actualised with code.:tests/clone_table.test.lua
