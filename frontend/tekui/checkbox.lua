-- Return checkbox object

-- Last mod.: 2024-11-11

local tui = require('tek.ui')
local force_merge = request('!.table.merge_and_patch')

return
  function(text, value, id, overrides)
    local params =
      {
        Text = text,
        Selected = value,
        Id = id,
        Width = 'fill',
      }
    local result = tui.CheckMark:new(params)
    force_merge(result, overrides)

    return result
  end

--[[
  2020-02
  2020-08
]]
