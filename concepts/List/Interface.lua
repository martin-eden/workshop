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
      [f] Add -- adds item to end
      [f] Remove -- removes item from start

      [f] GetFirst
      [f] GetLast
      [f] AddFirst
      [f] AddLast
      [f] RemoveFirst
      [f] RemoveLast

      [f] GetAt
      [f] AddBefore
      [f] AddAfter
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
local IsValidItem =
  function(Item)
    return not is_nil(Item)
  end

local GetNumItems =
  function(Items)
    return #Items
  end

Interface.IsValidItem = IsValidItem
Interface.GetNumItems = GetNumItems
-- )

-- ( Meta Level 2
local IsEmpty =
  function(Items)
    return (GetNumItems(Items) == 0)
  end

local GetFirstIndex =
  function(Items)
    if IsEmpty(Items) then return 0 end

    return 1
  end

local GetLastIndex =
  function(Items)
    if IsEmpty(Items) then return 0 end

    return GetNumItems(Items)
  end

local AssertValidItem =
  function(Item)
    assert(IsValidItem(Item), 'Invalid item')
  end

Interface.IsEmpty = IsEmpty
Interface.GetFirstIndex = GetFirstIndex
Interface.GetLastIndex = GetLastIndex
Interface.AssertValidItem = AssertValidItem
-- )

-- ( Meta Level 3
local AssertNotEmpty =
  function(Items)
    assert(not IsEmpty(Items), 'List is empty')
  end

local IsValidIndex =
  function(Items, index)
    return
      is_integer(index) and
      (index >= GetFirstIndex(Items)) and
      (index <= GetLastIndex(Items))
  end

Interface.AssertNotEmpty = AssertNotEmpty
Interface.IsValidIndex = IsValidIndex
-- )

-- ( Meta_Level_4
local AssertValidIndex =
  function(Items, index)
    assert(IsValidIndex(Items, index), 'Invalid index')
  end

Interface.AssertValidIndex = AssertValidIndex
-- )

-- ( Access Core
local GetAt =
  function(Items, index)
    return Items[index]
  end

local AddBefore =
  function(Items, index, Item)
    table.insert(Items, index, Item)
  end

local AddAfter =
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

local AddBefore =
  function(Items, index, Item)
    AssertValidIndex(Items, index)
    AssertValidItem(Item)

    AddBefore(Items, index, Item)
  end

local AddAfter =
  function(Items, index, Item)
    AssertValidIndex(Items, index)
    AssertValidItem(Item)

    AddAfter(Items, index, Item)
  end

local RemoveAt =
  function(Items, index)
    AssertValidIndex(Items, index)

    RemoveAt(Items, index)
  end

Interface.GetAt = GetAt
Interface.AddBefore = AddBefore
Interface.AddAfter = AddAfter
Interface.RemoveAt = RemoveAt
-- )

-- ( Access Level 2
local GetFirst =
  function(Items)
    AssertNotEmpty(Items)

    return GetAt(Items, GetFirstIndex(Items))
  end

local GetLast =
  function(Items)
    AssertNotEmpty(Items)

    return GetAt(Items, GetLastIndex(Items))
  end

local AddFirst =
  function(Items, item)
    AddBefore(Items, GetFirstIndex(Items), item)
  end

local AddLast =
  function(Items, item)
    AddAfter(Items, GetLastIndex(Items), item)
  end

local RemoveFirst =
  function(Items)
    AssertNotEmpty(Items)

    RemoveAt(Items, GetFirstIndex(Items))
  end

local RemoveLast =
  function(Items)
    AssertNotEmpty(Items)

    RemoveAt(Items, GetLastIndex(Items))
  end

Interface.GetFirst = GetFirst
Interface.GetLast = GetLast
Interface.AddFirst = AddFirst
Interface.AddLast = AddLast
Interface.RemoveFirst = RemoveFirst
Interface.RemoveLast = RemoveLast
-- )

-- ( Access Level 3
local Get =
  function(Items)
    return GetFirst(Items)
  end

local Add =
  function(Items, item)
    return AddLast(Items, item)
  end

local Remove =
  function(Items)
    return RemoveFirst(Items)
  end

Interface.Get = Get
Interface.Add = Add
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
