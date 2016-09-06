local safe_open = request('safe_open')

local file_as_string =
  function(file_name)
    local fIn = safe_open(file_name, 'rb')
    local result = fIn:read('a')
    fIn:close()
    return result
  end

return file_as_string
