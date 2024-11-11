-- Return group object

-- Last mod.: 2024-11-11

local tui = require('tek.ui')
local force_merge = request('!.table.merge_and_patch')

return
  function(header, overrides, ...)
    local params =
      force_merge(
        {
          Width = 'fill',
          Height = 'auto',
          Legend = header,
          Children = {...},
        },
        overrides
      )

    return tui.Group:new(params)
  end

--[[
  2020-02
]]
