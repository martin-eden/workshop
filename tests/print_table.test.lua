package.path = package.path .. ';../?.lua'
require('#base')

local print_table = request('^.debug.print_table')
print_table(_G, '_G')
