local generic_loader = request('^.^.mechs.generic_loader')
local syntax = request('syntax')
local struc_transformer = nil

return
  function(str)
    return generic_loader(str, syntax, struc_transformer)
  end
