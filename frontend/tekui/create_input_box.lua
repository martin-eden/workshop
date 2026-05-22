-- Create input box

--[[
  Author: Martin Eden
  Last mod.: 2026-05-22
]]

--[[
  Input data

    1 name [s]
    2 Overrides [?t]
]]

-- Imports:
local TekUi = require('tek.ui')
local merge_and_patch = request('!.table.merge_and_patch')

local create_input_box =
  function(name, Overrides)
    local Settings =
      {
        Id = name,
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
