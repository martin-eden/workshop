local parse = request('!.mechs.generic_loader')
local syntax = request('syntax')
local struc_to_lua = request('transform')

return
  function(dirtree_str)
    return parse(dirtree_str, syntax, struc_to_lua)
  end
