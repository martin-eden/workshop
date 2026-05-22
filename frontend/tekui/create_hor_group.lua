-- Create horizontal group

--[[
  Author: Martin Eden
  Last mod.: 2026-05-22
]]

--[[
  Create group with horizontal orientation

  Input format:

    {
      caption [?s] -- title text for group
      Contents [t] -- List of items
      Overrides [?t]
    }
]]

-- Imports:
local merge_and_patch = request('!.table.merge_and_patch')
local TekUi = require('tek.ui')

local create_hor_group =
  function(Group)
    local caption = Group.caption
    local Contents = Group.Contents
    local Overrides = Group.Overrides

    assert_table(Contents)

    local Settings =
      {
        Orientation = 'horizontal',
        Width = 'fill',
        Height = 'auto',
        Legend = caption,
        Children = Contents,
      }

    merge_and_patch(Settings, Overrides)

    return TekUi.Group:new(Settings)
  end

-- Export:
return create_hor_group

--[[
  2020-02
  2026-05-22
]]
