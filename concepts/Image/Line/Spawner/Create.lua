-- Create 1-d image

-- Last mod.: 2024-11-25

-- Imports:
local LineImage = request('^.Interface')
local NameList = request('!.concepts.List.AddNames')

local Names = { 'Colors', 'Length' }

local Create =
  function()
    local Result = new(LineImage)
    NameList(Result, Names)

    return Result
  end

-- Exports:
return Create

--[[
  2024-11-25
]]
