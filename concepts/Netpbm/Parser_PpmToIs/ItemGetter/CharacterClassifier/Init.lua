-- Fill module internals

-- Last mod.: 2025-03-28

-- Imports:
local ToList = request('!.table.to_list')
local MapValues = request('!.table.map_values')

-- Exports:
return
  function(self)
    self.SpaceMap = MapValues(ToList(self.Space))
    self.LineCommentStartMap = MapValues(ToList(self.LineCommentStart))
    self.LineCommentEndMap = MapValues(ToList(self.LineCommentEnd))
  end

--[[
  2025-03-28
]]
