--[[
  Make given table formally comply to reference template.

  Missing keys added. Mismatched value types set to match
  corresponding types in reference table.
]]

local verify_structure = request('!.table.verify_structure')
local reference = request('^.data.reference_structure')

return
  function(data)
    verify_structure(data, reference, true)
  end
