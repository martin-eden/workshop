--[[
  Sets specific values to valid BCD integers.

  Receives report table with invalid BCD integer nodes.
  Places in that nodes some valid BCD values.
]]

local path_get_value = request('!.table.path_get_value')
local path_set_value = request('!.table.path_set_value')
local to_bcd = request('!.number.to_bcd')

return
  function(data, report)
    for i, rec in ipairs(report) do
      local bad_value = path_get_value(data, rec.path)
      local high_digit = bad_value >> 4
      local low_digit = bad_value & 0x0F
      local max_valid_high_digit = (high_digit > 9) and 9 or high_digit
      local max_valid_value = max_valid_high_digit * 10 + 9
      local valid_bcd = to_bcd(math.random(0, max_valid_value))
      path_set_value(data, rec.path, valid_bcd)
    end
  end
