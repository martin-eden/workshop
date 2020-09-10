--[[
  Checks that specific values are BCD integers.
]]

local bcd_paths = request('^.data.bcd_paths')
local path_get_value = request('!.table.path_get_value')
local is_bcd = request('!.number.is_bcd')

return
  function(data)
    for _, path in ipairs(bcd_paths) do
      local value = path_get_value(data, path)
      local sub_result, sub_err_msg = is_bcd(value)
      if not sub_result then
        coroutine.yield(path, sub_err_msg)
      end
    end
  end
