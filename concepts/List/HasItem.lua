-- Check that list has given item

--[[
  Author: Martin Eden
  Last mod.: 2026-02-08
]]

return
  function(List, Item)
    -- Nothing fancy here. Our use cases are short short-lived lists
    for i = 1, #List do
      if (List[i] == Item) then
        return true
      end
    end
    return false
  end

--[[
  2026-02-08
]]
