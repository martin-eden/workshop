-- Merge destination table. Override existing fields in source table

--[[
  Author: Martin Eden
  Last mod.: 2026-04-30
]]

-- Imports:
local merge = request('merge')
local patch = request('patch')

local merge_and_patch =
  function(Dest, Source)
    merge(Dest, Source)
    patch(Dest, Source)

    return Dest
  end

-- Exports:
return merge_and_patch

--[[
  2024 #
  2026-04-30
]]
