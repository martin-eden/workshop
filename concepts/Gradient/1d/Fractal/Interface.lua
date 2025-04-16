-- 1-d plasm generator interface

-- Last mod.: 2025-04-16

-- Imports:
local LinearGenerator = request('^.Linear.Interface')
local MergeAndPatch = request('!.table.merge_and_patch')

local InterfaceExtensions =
  {
    -- [Before]
    Scale = 1.0,
    GetDistanceNoiseAmplitude = request('GetDistanceNoiseAmplitude'),

    -- [At]
    Run = request('Run'),

    -- [Internals]
    MaxDistance = 0.0,
    Plasm = request('Plasm'),
    CalculateMidwayPixel = request('CalculateMidwayPixel'),
    GetPixel = request('GetPixel'),
    MakeDistanceNoise = request('MakeDistanceNoise'),
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
]]
