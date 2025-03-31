-- .ppm text stream item getter

--[[
  Author: Martin Eden
  Last mod.: 2025-03-28
]]

return
  {
    -- [Config]
    Input = {},

    Init = request('Init'),
    GetNextItem = request('GetNextItem'),
    GetChunk = request('GetChunk'),

    -- [Internals]
    NextCharacter = '',
    CharacterClassifier = request('CharacterClassifier.Interface'),
    GetNextCharacter = request('GetNextCharacter'),
    SkipLineEnd = request('SkipLineEnd'),
  }

--[[
  2025-03-28
]]
