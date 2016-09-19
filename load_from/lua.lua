local syntax = request('^.parse.syntaxes.lua')
local postprocess_struc = request('lua.formatter_transformer')
local load = request('generic_loader')

return
  function(str)
    return load(str, syntax, postprocess_struc)
  end
