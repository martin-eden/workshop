-- Files/directories lister

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

return
  {
    -- Config
    SetBaseDirectory = request('SetBaseDirectory'),

    -- Run
    GetFiles = request('GetFiles'),
    GetDirectories = request('GetDirectories'),

    -- Internals
    BaseDir = './',
    RemoveBaseDirPrefix = request('RemoveBaseDirPrefix'),
  }

--[[
  2017-08-11
  2026-04-22
]]
