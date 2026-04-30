-- Check that our table values are same type as values from another table

--[[
  Author: Martin Eden
  Last mod.: 2026-04-30
]]

local values_are_same_type
values_are_same_type =
  function(OurTable, AnotherTable)
    for key in pairs(AnotherTable) do
      local our_val = OurTable[key]
      local another_val = AnotherTable[key]

      local our_type = type(our_val)
      local another_type = type(another_val)

      if (our_type ~= another_type) then
        return false
      end

      if (our_type == 'table') then
        if not values_are_same_type(our_val, another_val) then
          return false
        end
      end
    end

    return true
  end

local values_are_same_type_root =
  function(OurTable, AnotherTable)
    assert_table(OurTable)
    assert_table(AnotherTable)

    return values_are_same_type(OurTable, AnotherTable)
  end

-- Export:
return values_are_same_type_root

--[[
  2026-04-30
]]
