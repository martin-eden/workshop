local parse = request('!.mechs.generic_loader')
local syntax = request('load.syntax')

return
  function(str)
    return parse(str, syntax)
  end
