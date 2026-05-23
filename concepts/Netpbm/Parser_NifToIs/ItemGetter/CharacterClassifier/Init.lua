-- Fill module internals

-- Last mod.: 2026-05-23

-- Imports:
local MapValues = request('!.table.map_values')

-- Exports:
return
  function(self)
    self.SpaceMap = MapValues(self.Space)
    self.LineCommentStartMap = MapValues(self.LineCommentStart)
    self.LineCommentEndMap = MapValues(self.LineCommentEnd)
  end

--[[
  2025-03-28
]]
