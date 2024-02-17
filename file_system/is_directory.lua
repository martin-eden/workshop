local DirectoryExists = request('directory.exists')

return
  function(PathName)
    return DirectoryExists(PathName)
  end
