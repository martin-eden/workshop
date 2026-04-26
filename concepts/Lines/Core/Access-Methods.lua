-- Read/write functions for items

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

local GetItem =
  function(Me, index)
    return Me.Items[index]
  end

local SetItem =
  function(Me, item, index)
    Me.Items[index] = item
  end

local InsertItemBefore =
  function(Me, item, index)
    table.insert(Me.Items, index, item)
  end

local RemoveItemAt =
  function(Me, index)
    table.remove(Me.Items, index)
  end

-- Export:
return
  {
    GetItem = GetItem,
    SetItem = SetItem,
    InsertItemBefore = InsertItemBefore,
    RemoveItemAt = RemoveItemAt,
  }

--[[
  2026-04-26
]]
