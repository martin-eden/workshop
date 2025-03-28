-- Load given amount of items

-- Last mod.: 2025-03-28

--[[
  Get specified amount of items from input stream

  Return list of items.

  If failed, return nil.
]]
local GetChunk =
  function(self, NumItems)
    local Result = {}

    for _ = 1, NumItems do
      local Item = self:GetNextItem()

      if not Item then
        return
      end

      table.insert(Result, Item)
    end

    return Result
  end

-- Exports:
return GetChunk

--[[
  2024-11-03
]]
