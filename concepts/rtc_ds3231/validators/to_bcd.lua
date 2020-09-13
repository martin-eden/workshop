--[[
  Sets specific element value to some valid BCD integer.

  Receives data table and path for that table to problem element.
  Sets that element value to some valid BCD integer.
]]

local path_get_value = request('!.table.path_get_value')
local path_set_value = request('!.table.path_set_value')
local to_bcd = request('!.number.to_bcd')

return
  function(data, path)
    local bad_value = path_get_value(data, path)
    local high_digit = bad_value >> 4
    high_digit = (high_digit > 9) and 9 or high_digit
    local low_digit = bad_value & 0x0F
    low_digit = (low_digit > 9) and 9 or low_digit
    local valid_value = high_digit * 10 + low_digit
    local valid_bcd = to_bcd(valid_value)
    path_set_value(data, path, valid_bcd)
  end
