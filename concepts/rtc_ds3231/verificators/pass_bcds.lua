--[[
  Checks that specific values are BCD integers.
]]

local bcd_fields_to_rename = request('^.data.bcd_fields_to_rename')
local path_get_value = request('!.table.path_get_value')
local is_bcd = request('!.number.is_bcd')

return
  function(data)
    for _, rename_rec in ipairs(bcd_fields_to_rename) do
      local value = path_get_value(data, rename_rec.bcd)
      local sub_result, sub_err_msg = is_bcd(value)
      if not sub_result then
        coroutine.yield(rename_rec.bcd, sub_err_msg)
      end
    end
  end
