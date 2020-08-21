local pin_modes = request('pin_modes')
local invert_table = request('!.table.invert')

return invert_table(pin_modes)
