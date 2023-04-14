-- Current call chain holder.

--[[
  Status: works
  Vesrion: 3
  Last mod.: 2023-04-13
]]

return
  {
    Start = request('Start'),
    End = request('End'),
    --
    Stages = {},
    GetLastDepth = request('GetLastDepth'),
  }
