package.path = package.path .. ';../?.lua'
require('#base')

local parse = request('^.parse.path_name')
local print_table = request('^.debug.print_table')

local test_string
-- test_string = arg[0]
-- test_string = '~/Documents/research/base_structs/tests/parse_path.test.lua'
-- test_string = '~/Documents/research/base_structs/tests/'
-- test_string = '~/Documents/research/base_structs/tests'
-- test_string = '~/Documents/research/base_structs/tests//test.lua'
test_string = '~/Documents/research/base_structs/tests/../test.lua'

local result
result = parse(test_string)

print(('test_string: "%s"'):format(test_string))
print_table(result, 'result')
