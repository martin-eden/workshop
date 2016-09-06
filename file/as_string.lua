local chunk_name = 'as_string'

local file_as_string =
  function(file_name)
    local result
    local in_file = io.open(file_name, 'r')
    if in_file then
      result = in_file:read('*a')
      in_file:close()
    end
    return result
  end

tribute(chunk_name, file_as_string)
