require('#test_loader')

local copy_table = request('table.clone')
local print_table = request('table.print')

print('---original---')
print_table(bit32)
print('---clone---')
print_table(copy_table(bit32))
