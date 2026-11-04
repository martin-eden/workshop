-- Merge destination table. Override existing fields in source table

--[[
  Author: Martin Eden
  Last mod.: 2026-11-04
]]

local merge = request('merge')
local patch = request('patch')

return
  function(Dest, Additions)
    if not Additions then return end
    merge(Dest, Additions)
    patch(Dest, Additions)
  end

--[[
  2024 #
  2026 # #
  2026-11-04
]]
