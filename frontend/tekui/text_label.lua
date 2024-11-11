-- Return text label object

-- Last mod.: 2024-11-11

local tui = require('tek.ui')
local force_merge = request('!.table.merge_and_patch')

return
  function(text, overrides)
    local params =
      force_merge(
        {
          Class = 'caption',
          Width = 'fill',
          Text = text,
        },
        overrides
      )

    return tui.Text:new(params)
  end

--[[
  2020-02
]]
