-- Return scrollbar object

--[[
  Author: Martin Eden
  Last mod.: 2026-06-17
]]

-- Imports:
local tui = require('tek.ui')
local force_merge = request('!.table.merge_and_patch')

local create_scrollbar =
  function(id, min, max, Overrides)
    local Params =
      {
        Id = id,
        Min = min,
        Max = max,
      }

    force_merge(Params, Overrides)

    return tui.ScrollBar:new(Params)
  end

-- Export:
return create_scrollbar

--[[
  2020-02
]]
