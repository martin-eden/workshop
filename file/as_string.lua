local safe_open = request('safe_open')
local exists = request('exists')

return
  function(file_name, create_missing_file)
    if not exists(file_name) and create_missing_file then
      safe_open(file_name, 'w+'):write(''):close()
    end
    local f = safe_open(file_name, 'rb')
    local result = f:read('*a')
    f:close()
    return result
  end
