local FileExists = request('file.exists')

return
  function(PathName)
    return FileExists(PathName)
  end
