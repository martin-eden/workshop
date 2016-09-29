local generic_loader = request('^.generic_loader')
local syntax = request('^.^.parse.syntaxes.csv')
local struc_transormer = request('^.^.parse.csv.generic.restruc')

return
  function(str)
    return generic_loader(str, syntax, struc_transormer)
  end
