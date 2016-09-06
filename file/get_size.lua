local safe_open = request('safe_open')

local get_size =
  function(file_name)
    local f = safe_open(file_name, 'r')
    f:seek('end')
    local result = f:seek()
    f:close()
    return result
  end

return get_size
