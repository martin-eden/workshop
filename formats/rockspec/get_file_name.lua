local strip_updirs = request('!.string.file_name.strip_updirs')
local strip_self_prefix = request('!.string.file_name.strip_self_prefix')

return
  function(file_name)
    return strip_self_prefix(strip_updirs(file_name))
  end
