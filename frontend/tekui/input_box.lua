-- Create input box object

--[[
  Author: Martin Eden
  Last mod.: 2026-05-22
]]

-- Imports:
local TekUi = require('tek.ui')
local merge_and_patch = request('!.table.merge_and_patch')

local create_input_box =
  function(text, name, Overrides)
    local Settings =
      {
        Id = name,
        Text = text,
        Width = 'free',
      }

    merge_and_patch(Settings, Overrides)

    return TekUi.Input:new(Settings)
  end

-- Export:
return create_input_box

--[[
  2020-02
  2020-08
  2026-05-22
]]
