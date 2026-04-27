-- Create window object

--[[
  Author: Martin Eden
  Last mod.: 2026-04-27
]]

-- Imports:
local TekUi = require('tek.ui')
local force_merge = request('!.table.merge_and_patch')

-- Create TekUI's window with our content
local create_window =
  function(title_str, Overrides, Children)
    local Params =
      force_merge(
        {
          Title = title_str,
          Children = { Children },
          Id = 'main-window',
          Status = 'hide',
          HideOnEscape = true,
          Orientation = 'vertical',
          Width = 'free',
          Height = 'free',
        },
        Overrides
      )

    return TekUi.Window:new(Params)
  end

-- Export:
return create_window

--[[
  2020 # #
  2026-04-27
]]
