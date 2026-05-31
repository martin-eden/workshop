-- Traverse table by list of indices. Set final node

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

-- Traverse and set. If current node has no index, create table with that index
local go_and_set =
  function(Node, Path, Value)
    local Index

    for i = 1, #Path - 1 do
      local Index = Path[i]
      if is_nil(Node[Index]) then
        Node[Index] = { }
      end
      Node = Node[Index]
    end

    Index = Path[#Path]
    Node[Index] = Value
  end

-- Export:
return go_and_set

--[[
  2026-01-14
  2026-05-31
]]
