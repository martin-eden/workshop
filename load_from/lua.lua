local syntax = request('^.parse.syntaxes.lua')
local postprocess_struc = request('lua.formatter_transformer')
local parse = request('generic_loader')

return
  function(str)
    return parse(str, syntax, postprocess_struc)
  end
