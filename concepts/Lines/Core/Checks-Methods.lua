-- Data checking/assertion functions

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

local AssertValidIndex =
  function(Me, index)
    assert_integer(index)

    local num_items = Me:GetNumItems(Me)

    if (num_items == 0) then
      assert((index == 0) or (index == 1))
    else
      assert((index >= 1) and (index <= num_items))
    end
  end

local AssertValidValue =
  function(Me, str)
    assert_string(str)
  end

-- Export:
return
  {
    AssertValidIndex = AssertValidIndex,
    AssertValidValue = AssertValidValue,
  }

--[[
  2026-04-26
]]
