-- Return button object

-- Last mod.: 2024-11-11

local tui = require('tek.ui')
local force_merge = request('!.table.merge_and_patch')

return
  function(text, overrides)
    local result =
      tui.Text:new(
        {
          Mode = 'button',
          Class = 'button',
          Text = text,
          KeyCode = true,
          Width = 'free',
        }
      )
    force_merge(result, overrides)

    return result
  end

--[[
  2020-02
  2020-08
]]
