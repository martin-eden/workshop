-- Encode/decode .ppm file to Lua table

-- Last mod.: 2025-03-29

-- Exports:
return
  {
    -- [Config]
    Settings = request('Settings.Interface'),

    Input = request('!.concepts.StreamIo.Input'),
    Output = request('!.concepts.StreamIo.Output'),

    -- [Main]
    Load = request('Load'),
    Save = request('Save'),
  }

--[[
  2024-11-04
  2025-03-29
]]
