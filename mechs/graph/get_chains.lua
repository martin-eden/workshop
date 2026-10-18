-- Get list of chains from graph

--[[
  Author: Martin Eden
  Last mod.: 2026-10-18
]]

-- Originally written in "Lua-Callgraph" project

--[[
  Input format

    [t] list of node's links
      i [t] list of adjacent node indices
        0+ [i] adjacent node index
]]

local get_num_entries = request('!.table.get_num_entries')
local ordered_pass = request('!.table.ordered_pass')
local add_to_list = request('!.concepts.list.add_item')

-- Export:
return
  function(Links)
    local Chains = { }

    local VisitedNodes_Map = { }

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

        if not NextOnes or (get_num_entries(NextOnes) == 0) then
          add_to_list(Chains, Chain)
          return
        end

        local is_first_rec = true
        for _, next_one_index in ordered_pass(NextOnes) do
          if is_first_rec then
            walk_chain(next_one_index, Chain)
            is_first_rec = false
          else
            walk_chain(next_one_index, { start_node })
          end
        end
      end

    for start_node in ordered_pass(Links) do
      if not VisitedNodes_Map[start_node] then
        walk_chain(start_node, { })
      end
    end

    return Chains
  end

--[[
  2026 #
  2026-10-18
]]
