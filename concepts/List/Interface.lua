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
local merge_table = request('!.table.merge')
local create_instance = request('!.table.create_instance')

local Meta_Level_1 =
  {
    GetFirstIndex =
      function(Items)
        return 1
      end,

    GetLastIndex =
      function(Items)
        return #Items
      end,

    IsValidItem =
      function(Item)
        return not is_nil(Item)
      end,
  }

local Meta_Level_2 =
  {
    GetNumItems =
      function(Items)
        return
          1 +
          (
            Meta_Level_1.GetLastIndex(Items) -
            Meta_Level_1.GetFirstIndex(Items)
          )
      end,

    IsValidIndex =
      function(Items, index)
        return
          is_integer(index) and
          (index >= Meta_Level_1.GetFirstIndex(Items)) and
          (index <= Meta_Level_1.GetLastIndex(Items))
      end,

    AssertValidItem =
      function(Item)
        assert(Meta_Level_1.IsValidItem(Item), 'Invalid item')
      end,
  }

local Meta_Level_3 =
  {
    IsEmpty =
      function(Items)
        return (Meta_Level_2.GetNumItems(Items) == 0)
      end,

    AssertValidIndex =
      function(Items, index)
        assert(Meta_Level_2.IsValidIndex(Items, index), 'Invalid index')
      end,
  }

local Meta_Level_4 =
  {
    AssertNotEmpty =
      function(Items)
        assert(not Meta_Level_3.IsEmpty(Items), 'List is empty')
      end,
  }

local Access_Core =
  {
    GetAt =
      function(Items, index)
        return Items[index]
      end,

    InsertBefore =
      function(Items, index, Item)
        table.insert(Items, index, Item)
      end,

    InsertAfter =
      function(Items, index, Item)
        table.insert(Items, index + 1, Item)
      end,

    RemoveAt =
      function(Items, index)
        table.remove(Items, index)
      end,
  }

local Access_Level_1 =
  {
    GetAt =
      function(Items, index)
        Meta_Level_3.AssertValidIndex(Items, index)

        return Access_Core.GetAt(Items, index)
      end,

    InsertBefore =
      function(Items, index, Item)
        Meta_Level_3.AssertValidIndex(Items, index)
        Meta_Level_2.AssertValidItem(Item)

        Access_Core.InsertBefore(Items, index, Item)
      end,

    InsertAfter =
      function(Items, index, Item)
        Meta_Level_3.AssertValidIndex(Items, index)
        Meta_Level_2.AssertValidItem(Item)

        Access_Core.InsertAfter(Items, index, Item)
      end,

    RemoveAt =
      function(Items, index)
        Meta_Level_3.AssertValidIndex(Items, index)

        Access_Core.RemoveAt(Items, index)
      end,
  }

local Access_Level_2 =
  {
    GetFirst =
      function(Items)
        return
          Access_Level_1.GetAt(Items, Meta_Level_1.GetFirstIndex(Items))
      end,

    GetLast =
      function(Items)
        return
          Access_Level_1.GetAt(Items, Meta_Level_1.GetLastIndex(Items))
      end,

    InsertFirst =
      function(Items, item)
        Access_Level_1.InsertBefore(Items, Meta_Level_1.GetFirstIndex(Items), item)
      end,

    InsertLast =
      function(Items, item)
        Access_Level_1.InsertAfter(Items, Meta_Level_1.GetLastIndex(Items), item)
      end,

    RemoveFirst =
      function(Items)
        Access_Level_1.RemoveAt(Items, Meta_Level_1.GetFirstIndex(Items))
      end,

    RemoveLast =
      function(Items)
        Access_Level_1.RemoveAt(Items, Meta_Level_1.GetLastIndex(Items))
      end,
  }

local Access_Level_3 =
  {
    Get =
      function(Items)
        return Access_Level_2.GetFirst(Items)
      end,

    Insert =
      function(Items, item)
        return Access_Level_2.InsertLast(Items, item)
      end,

    Remove =
      function(Items)
        return Access_Level_2.RemoveFirst(Items)
      end,
  }

local Interface = { }

merge_table(Interface, Meta_Level_1)
merge_table(Interface, Meta_Level_2)
merge_table(Interface, Meta_Level_3)
merge_table(Interface, Meta_Level_4)
merge_table(Interface, Access_Level_1)
merge_table(Interface, Access_Level_2)
merge_table(Interface, Access_Level_3)

Interface.create =
  function(Items)
    return create_instance(Items, Interface)
  end

-- Export:
return Interface

--[[
  2026-05-27
]]
