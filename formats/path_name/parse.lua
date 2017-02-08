local split_string = request('^.^.string.split')

return
  function(path_name)
    return split_string(path_name, '%/')
  end
