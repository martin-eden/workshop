-- Shell script writer

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

local Interface =
  {
    -- [Setup]
    DeleteDir = request('DeleteDir'),
    CopyFile = request('CopyFile'),

    -- [Main]
    GetScript = request('GetScript'),

    -- [Internal]
    FilesToCopy = { },
    DirsToDelete = { },
  }

-- Export:
return Interface

--[[
  2018
  2026-05-28
]]
