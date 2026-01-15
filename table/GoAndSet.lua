-- Traverse table by list of indices. Set final node

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

return
  -- Traverse and set. If current node has no index, create table with that index
  function(t, Path, Value)
    local Node = t
    local Index

    for i = 1, #Path - 1 do
      local Index = Path[i]
      if is_nil(Node[Index]) then
        Node[Index] = {}
      end
      Node = Node[Index]
    end

    Index = Path[#Path]
    Node[Index] = Value
  end

-- 2026-01-14
