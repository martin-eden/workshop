-- Itness parser interface

-- Imports:
local Input = request('!.concepts.StreamIo.Input')
local Syntax = request('^.Syntax')

-- Exports:
return
  {
    -- [Config] Input implementer. Set to concrete before use
    Input = Input,

    -- [Main] Parse input to strings tree
    Run = request('Run'),

    -- [Internal] Syntax characters
    Syntax = Syntax,
  }

--[[
  2024-10-21
]]
