--[[
  Verify parsed table for formal correctness.

  So it should have all required fields with correct type.
]]

local verify_structure = request('!.table.verify_structure')
local reference = request('^.data.reference_structure')

return
  function(data)
    if not verify_structure(data, reference) then
      coroutine.yield()
    end
  end
