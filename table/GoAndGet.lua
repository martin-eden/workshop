-- Traverse table by list of indices. Return final node

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

--[[
  I remember I wrote this near 2016.
]]

return
  function(t, Path)
    -- In case of non-existent path we return nil
    local Result = t
    for i = 1, #Path do
      local Index = Path[i]
      Result = Result[Index]
      if is_nil(Result) then
        return nil
      end
    end
    return Result
  end

-- 2026-01-14
