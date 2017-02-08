local generic_loader = request('^.^.^.mechs.generic_loader')
local syntax = request('^.syntax')
local struc_transormer = request('^.transform.generic.restruc')

return
  function(str)
    return generic_loader(str, syntax, struc_transormer)
  end
