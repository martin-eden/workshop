-- Create 2-d image

-- Last mod.: 2024-11-25

-- Imports:
local TwoDimImage = request('^.Interface')

local Names = { 'Lines', 'NumLines' }
local NameList = request('!.concepts.List.AddNames')

local Create =
  function()
    local Result = new(TwoDimImage)
    NameList(Result, Names)

    return Result
  end

-- Exports:
return Create

--[[
  2024-11-25
]]
