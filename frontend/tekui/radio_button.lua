-- Return radio button object

-- Last mod.: 2024-11-11

local tui = require('tek.ui')
local force_merge = request('!.table.merge_and_patch')

return
  function(text, value, id, overrides)
    local result =
      tui.RadioButton:new(
        {
          Text = text,
          Selected = value,
          Id = id,
        }
      )
    force_merge(result, overrides)

    return result
  end

--[[
  2020-02
]]
