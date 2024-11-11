-- Return scrollbar object

-- Last mod.: 2024-11-11

local tui = require('tek.ui')
local force_merge = request('!.table.merge_and_patch')

return
  function(id, min, max, overrides)
    local params =
      force_merge(
        {
          Id = id,
          Min = min,
          Max = max,
        },
        overrides
      )

    return tui.ScrollBar:new(params)
  end

--[[
  2020-02
]]
