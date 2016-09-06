package.path = package.path .. ';../?.lua'
require('#base')

local test_table = request('#table_samples').multitype_table

local sorted_pairs = request('^.table.default_ordered_pass')
print('key', 'key_type', 'value', 'value_type')
for k, v in sorted_pairs(test_table) do
  print(k, type(k), v, type(v))
end
