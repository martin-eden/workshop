local syntax = request('^.^.parse.syntaxes.json')
local struc_to_lua = request('^.^.parse.json.struc_to_lua')

local parse = request('^.generic_loader')

return
  function(json_str)
    return parse(json_str, syntax, struc_to_lua)
  end
