-- Return radio button object

--[[
  Author: Martin Eden
  Last mod.: 2026-05-12
]]

-- Imports:
local tui = require('tek.ui')
local force_merge = request('!.table.merge_and_patch')

return
  function(text, id, Overrides)
    local Result =
      tui.RadioButton:new(
        {
          Text = text,
          Id = id,
        }
      )
    force_merge(Result, Overrides)

    return Result
  end

--[[
  2020-02
  2026-05-12
]]
