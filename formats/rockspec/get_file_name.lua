local strip_updirs = request('strip_updirs')
local strip_self_prefix = request('strip_self_prefix')

return
  function(file_name)
    return strip_self_prefix(strip_updirs(file_name))
  end
