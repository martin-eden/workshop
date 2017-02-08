local parse = request('^.^.^.mechs.generic_loader')
local syntax = request('^.syntax')
local struc_to_lua = request('^.transform.struc_to_lua')

return
  function(json_str)
    return parse(json_str, syntax, struc_to_lua)
  end
