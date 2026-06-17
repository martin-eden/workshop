-- Return text label object

--[[
  Author: Martin Eden
  Last mod.: 2026-06-17
]]

-- Imports:
local tui = require('tek.ui')
local force_merge = request('!.table.merge_and_patch')

local create_text_label =
  function(text, Overrides)
    local Params =
      {
        Class = 'caption',
        Width = 'fill',
        Text = text,
      }

    force_merge(Params, Overrides)

    return tui.Text:new(Params)
  end

-- Export:
return create_text_label

--[[
  2020-02
]]
