-- Shortcut to overwrite values in destination table according to patch

--[[
  Author: Martin Eden
  Last mod.: 2024-11-11
]]

-- Imports:
local patch = request('patch')

local hard_patch =
  function(Result, Additions)
    return patch(Result, Additions)
  end

-- Export:
return hard_patch

--[[
  2024-11-11
]]
