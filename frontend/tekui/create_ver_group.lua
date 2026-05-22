-- Create vertical group

--[[
  Author: Martin Eden
  Last mod.: 2026-05-22
]]

--[[
  Create group with vertical orientation

  Input format:

    {
      caption [?s] -- title text for group
      Contents [t] -- List of items
      Overrides [?t]
    }
]]

-- Imports:
local merge_and_patch = request('!.table.merge_and_patch')
local create_hor_group = request('create_hor_group')

local create_ver_group =
  function(Group)
    local OrigGroupOverrides = Group.Overrides

    local Overrides =
      {
        Orientation = 'vertical',
        Width = 'auto',
        Height = 'fill',
       }

    merge_and_patch(Overrides, Group.Overrides)

    Group.Overrides = Overrides

    local Result = create_hor_group(Group)

    Group.Overrides = OrigGroupOverrides

    return Result
  end

-- Export:
return create_ver_group

--[[
  2020-02
  2026-05-22
]]
