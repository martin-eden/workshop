-- 2-d "plasm" generation

--[[
  Author: Martin Eden
  Last mod.: 2025-04-16
]]

-- Imports:
local MergeAndPatch = request('!.table.merge_and_patch')
local BaseInterface = request('^.Bilinear.Interface')

local InterfaceExtensions =
  {
    -- [Before]
    Scale = 1.0,
    GetDistanceNoiseAmplitude = request('GetDistanceNoiseAmplitude'),

    -- [At]
    Run = request('Run'),

    -- [Internals]
    MaxDistance = 1.0,
    Plasm = request('Plasm'),
    SpawnMiddlePoint = request('SpawnMiddlePoint'),
    CalcDistance = request('CalcDistance'),
    ObservePoint = request('ObservePoint'),
  }

local Interface = MergeAndPatch(new(BaseInterface), InterfaceExtensions)

-- Exports:
return Interface

--[[
  2025-04-04
  2025-04-11
  2025-04-14
  2025-04-16
]]
