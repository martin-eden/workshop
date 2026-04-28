-- Create and return group object

--[[
  Author: Martin Eden
  Last mod.: 2026-04-27
]]

-- Imports:
local TekUi = require('tek.ui')
local force_merge = request('!.table.merge_and_patch')

local create_group =
  function(header, Overrides, ...)
    local Params =
      force_merge(
        {
          Legend = header,
          Children = { ... },
          Width = 'fill',
          Height = 'auto',
        },
        Overrides
      )

    return TekUi.Group:new(Params)
  end

-- Export:
return create_group

--[[
  2020 #
  2026-04-27
]]
