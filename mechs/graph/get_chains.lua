-- Get list of chains from graph

--[[
  Author: Martin Eden
  Last mod.: 2026-11-12
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

return
  function(links)
    local chains = { }

    local visited = { }

    local walk_chain
    walk_chain =
      function(start_node, chain)
        add_to_list(chain, start_node)

        if visited[start_node] then
          add_to_list(chains, chain)
          return
        end

        visited[start_node] = true

        local next_ones = links[start_node]

        if not next_ones or (get_num_entries(next_ones) == 0) then
          add_to_list(chains, chain)
          return
        end

        local is_first_rec = true
        for _, next_one_index in ordered_pass(next_ones) do
          if is_first_rec then
            walk_chain(next_one_index, chain)
            is_first_rec = false
          else
            walk_chain(next_one_index, { start_node })
          end
        end
      end

    for start_node in ordered_pass(links) do
      if not visited[start_node] then
        walk_chain(start_node, { })
      end
    end

    return chains
  end

--[[
  2026 #
  2026-10-18
]]
