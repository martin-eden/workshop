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
      [f] Get -- gets last item
      [f] Add -- adds item to end
      [f] Remove -- removes last item

      [f] AssertNotEmpty
      [f] AssertValidItem
      [f] IsEmpty
      [f] IsValidItem
    )

  Must raise error at:

    * getting from empty list
    * adding nil item
    * removing from empty list
]]

-- Imports:
local attach_methods = request('!.table.attach_methods')

local Interface = { }

-- ( Meta Level 1
local IsValidItem =
  function(Item)
    return not is_nil(Item)
  end

local IsEmpty =
  function(Items)
    return (#Items == 0)
  end

Interface.IsEmpty = IsEmpty
Interface.IsValidItem = IsValidItem
-- )

-- ( Meta Level 2
local AssertValidItem =
  function(Item)
    assert(IsValidItem(Item), 'Invalid item')
  end

local AssertNotEmpty =
  function(Items)
    assert(not IsEmpty(Items), 'List is empty')
  end

Interface.AssertValidItem = AssertValidItem
Interface.AssertNotEmpty = AssertNotEmpty
-- )

-- ( Access Core
local GetLast =
  function(Items)
    return Items[#Items]
  end

local AddLast =
  function(Items, item)
    table.insert(Items, item)
  end

local RemoveLast =
  function(Items)
    table.remove(Items)
  end
-- )

-- ( Access Level 1
local GetLast =
  function(Items)
    AssertNotEmpty(Items)

    return GetLast(Items)
  end

local AddLast =
  function(Items, item)
    AssertValidItem(item)

    AddLast(Items, item)
  end

local RemoveLast =
  function(Items)
    AssertNotEmpty(Items)

    RemoveLast(Items)
  end

Interface.Get = GetLast
Interface.Add = AddLast
Interface.Remove = RemoveLast
-- )

local create =
  function(Items)
    attach_methods(Items, Interface)

    return Items
  end

Interface.create = create

-- Export:
return Interface

--[[
  2026-05-27
  2026-05-28
]]
