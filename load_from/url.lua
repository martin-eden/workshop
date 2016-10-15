local generic_loader = request('generic_loader')
local syntax = request('^.parse.syntaxes.url')
local struc_transormer = nil

return
  function(str)
    return generic_loader(str, syntax, struc_transormer)
  end
