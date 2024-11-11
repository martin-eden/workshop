-- Return input box object

-- Last mod.: 2024-11-11

local tui = require('tek.ui')
local force_merge = request('!.table.merge_and_patch')

return
  function(text, id, overrides)
    local result =
      tui.Input:new(
        {
          Text = text,
          Id = id,
          Width = 'free',
          MinWidth = 0,
        }
      )
    force_merge(result, overrides)

    return result
  end

--[[
  2020-02
  2020-08
]]
