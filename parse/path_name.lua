local split_string = request('^.string.split')

local path_parse =
  function(path_name)
    return split_string(path_name, '%/')
  end

return path_parse
