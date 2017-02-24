local parse = request('!.mechs.generic_loader')
local syntax = request('load.syntax')
local struc_to_lua = request('load.struc_to_lua')

return
  function(json_str)
    return parse(json_str, syntax, struc_to_lua)
  end
