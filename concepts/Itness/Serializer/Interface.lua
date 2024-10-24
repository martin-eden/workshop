-- String trees serializer interface

-- Imports:
local Output = request('!.concepts.StreamIo.Output')

-- Exports:
return
  {
    -- [Config] Output implementer. Set to more concrete specie!
    Output = Output,

    -- [Main] Serialize strings tree to output
    Run = request('Run'),
  }

--[[
  2024-09-03
]]
