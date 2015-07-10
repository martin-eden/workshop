require('#test_loader')

local test_table =
  {
    z = '12',
    abc = '345',
    6,
    7,
    [3] = '8',
    ["1"] = 2,
  }

local sorted_pairs = request('table.ordered_pass')
print('key', 'key_type', 'value', 'value_type')
for k, v in sorted_pairs(test_table) do
  print(k, type(k), v, type(v))
end
