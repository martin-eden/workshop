-- 1-d plasm generator interface

-- Last mod.: 2025-04-23

-- Imports:
local LinearGenerator = request('^.Linear.Interface')
local MergeAndPatch = request('!.table.merge_and_patch')

local InterfaceExtensions =
  {
    -- [At]
    Run = request('Run'),

    -- [Internals]
    Plasm = request('Plasm'),
  }

local Interface =
  MergeAndPatch(new(LinearGenerator), InterfaceExtensions)

-- Export:
return Interface

--[[
  2024-09 #
  2024-11 # #
  2025-03 #
  2025-04-04
  2025-04-05
  2024-04-06
  2024-04-15
  2025-04-23
]]
