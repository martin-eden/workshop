-- Return true if interface is applicable

-- Last mod.: 2024-07-19

local VerifyStructure = request('!.table.verify_structure')

return
  function(Instance, Interface)
    return VerifyStructure(Instance, Interface)
  end
