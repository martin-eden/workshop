local get_check_func = request('get_check_func')
local syntels = request('syntels')

return
  function()
    local result = {}
    for i = 1, #syntels do
      local func_name = ('is_%s'):format(syntels[i])
      local func = get_check_func(syntels[i])
      result[func_name] = func
    end
    return result
  end
