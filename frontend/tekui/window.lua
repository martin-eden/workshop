-- Return window object

-- Last mod.: 2024-11-11

local tui = require('tek.ui')
local force_merge = request('!.table.merge_and_patch')

return
  function(title, overrides, content)
    local params =
      force_merge(
        {
          Id = 'main-window',
          Title = title,
          Status = 'hide',
          HideOnEscape = true,
          Orientation = 'vertical',
          Children = {content},
          Width = 'free',
          Height = 'free',
        },
        overrides
      )

    return tui.Window:new(params)
  end

--[[
  2020-02
  2020-08
]]
