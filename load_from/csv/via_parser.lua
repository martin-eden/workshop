local generic_loader = request('^.generic_loader')
local syntax = request('^.^.parse.syntaxes.csv').default
local struc_transormer = request('^.^.parse.csv.struc_to_lua')

return
  function(str)
    return generic_loader(str, syntax, struc_transormer)
  end
