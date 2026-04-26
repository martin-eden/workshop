-- Core functions for strings list

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

local Checks = request('Checks-Methods')
local ImpExp = request('ImpExp-Methods')
local Access = request('Access-Methods')

local GetNumItems =
  function(Me)
    return #Me.Items
  end

return
  {
    Items = {},

    -- Discovery:
    GetNumItems = GetNumItems,

    -- Checks:
    AssertValidIndex = Checks.AssertValidIndex,
    AssertValidValue = Checks.AssertValidValue,

    -- Import/export
    ToItem = ImpExp.ToItem,
    FromString = ImpExp.FromString,
    ToString = ImpExp.ToString,

    -- Read/write
    GetItem = Access.GetItem,
    SetItem = Access.SetItem,
    InsertItemBefore = Access.InsertItemBefore,
    RemoveItemAt = Access.RemoveItemAt,
  }

--[[
  2024 # #
  2026-04-26
]]
