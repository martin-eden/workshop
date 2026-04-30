-- Check that our table have keys from another table

--[[
  Author: Martin Eden
  Last mod.: 2026-04-30
]]

local values_are_present
values_are_present =
  function(OurTable, AnotherTable)
    for key in pairs(AnotherTable) do
      if not OurTable[key] then
        return false
      end

      local our_val = OurTable[key]
      local another_val = AnotherTable[key]

      if is_table(our_val) and is_table(another_val) then
        if not values_are_present(our_val, another_val) then
          return false
        end
      end
    end

    return true
  end

local values_are_present_root =
  function(OurTable, AnotherTable)
    assert_table(OurTable)
    assert_table(AnotherTable)

    return values_are_present(OurTable, AnotherTable)
  end

-- Export:
return values_are_present_root

--[[
  2026-04-30
]]
