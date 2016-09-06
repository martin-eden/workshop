package.path = package.path .. ';../?.lua'
require('#base')

local simple_print = request('debug.print_anytype_simple')
-- local sample_table = request('tests.#table_samples').simple_folded_table
local sample_table = request('tests.#table_samples').multitype_table
local table_iterator = request('table.ordered_pass')

local result = simple_print(sample_table, table_iterator)

print(result)
