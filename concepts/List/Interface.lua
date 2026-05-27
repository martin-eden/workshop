-- List interface

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

--[[
  Contract

  Code

    local List = request('!.concepts.List.Interface')

    local OurList = List.create({})

  must return data table { } with attached metatable:

    (
      [f] Get -- gets the first item
      [f] Insert -- adds item to end
      [f] Remove -- removes item from start

      [f] GetFirst
      [f] GetLast
      [f] InsertFirst
      [f] InsertLast
      [f] RemoveFirst
      [f] RemoveLast

      [f] GetAt
      [f] InsertBefore
      [f] InsertAfter
      [f] RemoveAt

      [f] AssertNotEmpty
      [f] AssertValidIndex
      [f] AssertValidItem
      [f] IsEmpty
      [f] IsValidIndex
      [f] GetNumItems
      [f] GetFirstIndex
      [f] GetLastIndex
      [f] IsValidItem
    )
]]

-- Imports:
local create_instance = request('!.table.create_instance')

local Interface = { }

-- ( Meta Level 1
local GetFirstIndex =
  function(Items)
    return 1
  end

local GetLastIndex =
  function(Items)
    return #Items
  end

local IsValidItem =
  function(Item)
    return not is_nil(Item)
  end

Interface.GetFirstIndex = GetFirstIndex
Interface.GetLastIndex = GetLastIndex
Interface.IsValidItem = IsValidItem
-- )

-- ( Meta Level 2
local GetNumItems =
  function(Items)
    return 1 + (GetLastIndex(Items) - GetFirstIndex(Items))
  end

local IsValidIndex =
  function(Items, index)
    return
      is_integer(index) and
      (index >= GetFirstIndex(Items)) and
      (index <= GetLastIndex(Items))
  end

local AssertValidItem =
  function(Item)
    assert(IsValidItem(Item), 'Invalid item')
  end

Interface.GetNumItems = GetNumItems
Interface.IsValidIndex = IsValidIndex
Interface.AssertValidItem = AssertValidItem
-- )

-- ( Meta Level 3
local IsEmpty =
  function(Items)
    return (GetNumItems(Items) == 0)
  end

local AssertValidIndex =
  function(Items, index)
    assert(IsValidIndex(Items, index), 'Invalid index')
  end

Interface.IsEmpty = IsEmpty
Interface.AssertValidIndex = AssertValidIndex
-- )

-- ( Meta_Level_4
local AssertNotEmpty =
  function(Items)
    assert(not IsEmpty(Items), 'List is empty')
  end

Interface.AssertNotEmpty = AssertNotEmpty
-- )

-- ( Access Core
local GetAt =
  function(Items, index)
    return Items[index]
  end

local InsertBefore =
  function(Items, index, Item)
    table.insert(Items, index, Item)
  end

local InsertAfter =
  function(Items, index, Item)
    table.insert(Items, index + 1, Item)
  end

local RemoveAt =
  function(Items, index)
    table.remove(Items, index)
  end
-- )

-- ( Access Level 1
local GetAt =
  function(Items, index)
    AssertValidIndex(Items, index)

    return GetAt(Items, index)
  end

local InsertBefore =
  function(Items, index, Item)
    AssertValidIndex(Items, index)
    AssertValidItem(Item)

    InsertBefore(Items, index, Item)
  end

local InsertAfter =
  function(Items, index, Item)
    AssertValidIndex(Items, index)
    AssertValidItem(Item)

    InsertAfter(Items, index, Item)
  end

local RemoveAt =
  function(Items, index)
    AssertValidIndex(Items, index)

    RemoveAt(Items, index)
  end

Interface.GetAt = GetAt
Interface.InsertBefore = InsertBefore
Interface.InsertAfter = InsertAfter
Interface.RemoveAt = RemoveAt
-- )

-- ( Access Level 2
local GetFirst =
  function(Items)
    return GetAt(Items, GetFirstIndex(Items))
  end

local GetLast =
  function(Items)
    return GetAt(Items, GetLastIndex(Items))
  end

local InsertFirst =
  function(Items, item)
    InsertBefore(Items, GetFirstIndex(Items), item)
  end

local InsertLast =
  function(Items, item)
    InsertAfter(Items, GetLastIndex(Items), item)
  end

local RemoveFirst =
  function(Items)
    RemoveAt(Items, GetFirstIndex(Items))
  end

local RemoveLast =
  function(Items)
    RemoveAt(Items, GetLastIndex(Items))
  end

Interface.GetFirst = GetFirst
Interface.GetLast = GetLast
Interface.InsertFirst = InsertFirst
Interface.InsertLast = InsertLast
Interface.RemoveFirst = RemoveFirst
Interface.RemoveLast = RemoveLast
-- )

-- ( Access Level 3
local Get =
  function(Items)
    return GetFirst(Items)
  end

local Insert =
  function(Items, item)
    return InsertLast(Items, item)
  end

local Remove =
  function(Items)
    return RemoveFirst(Items)
  end

Interface.Get = Get
Interface.Insert = Insert
Interface.Remove = Remove
-- )

local create =
  function(Items)
    return create_instance(Items, Interface)
  end

Interface.create = create

-- Export:
return Interface

--[[
  2026-05-27
]]
