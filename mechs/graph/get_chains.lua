-- Get list of chains from graph

--[[
  Author: Martin Eden
  Last mod.: 2026-10-15
]]

-- Originally written in "Lua-Callgraph" project

--[[
  Input format

    [t] list of node's links
      i [t] list of adjacent node indices
        0+ [i] adjacent node index
]]

local add_to_list = request('!.concepts.list.add_item')

-- Export:
return
  function(Links)
    local num_nodes = #Links

    local Chains = { }

    local VisitedNodes_Map = { }
    for i = 1, num_nodes do
      VisitedNodes_Map[i] = false
    end

    local walk_chain
    walk_chain =
      function(start_node, Chain)
        add_to_list(Chain, start_node)

        if VisitedNodes_Map[start_node] then
          add_to_list(Chains, Chain)
          return
        end

        VisitedNodes_Map[start_node] = true

        local NextOnes = Links[start_node]
        local num_next_ones = #NextOnes

        if (num_next_ones == 0) then
          add_to_list(Chains, Chain)
          return
        end

        walk_chain(NextOnes[1], Chain)

        for next_one_index = 2, num_next_ones do
          local InnerChain = { start_node }
          walk_chain(NextOnes[next_one_index], InnerChain)
        end
      end

    for start_node = 1, num_nodes do
      if not VisitedNodes_Map[start_node] then
        walk_chain(start_node, { })
      end
    end

    return Chains
  end

--[[
  2026-09-13
]]
