-- Serialize graph to .dot format

--[[
  Author: Martin Eden
  Last mod.: 2026-11-28
]]

--[[
  .dot (DAG of tomorrow) is text format for graphs

  It's described at

    https://graphviz.org/doc/info/lang.html

  (and also described by "$ man dot")

  and mentioned at

    https://en.wikipedia.org/wiki/DOT_(graph_description_language)

  It has expressive syntax and nice for manual editing.
]]

--[[
  Input format

    1 [t] graph
      1 [t] labels list
        i [s] label for node at that index
      2 [t] links list
        i [t] list of adjacent nodes indices for node at given index
          0+ [i] adjecent node index
    2 [t] output stream instance
]]

local get_num_entries = request('!.table.get_num_entries')
local writer = request('writer')
local ordered_pass = request('!.table.ordered_pass')
local get_chains = request('!.mechs.graph.get_chains')

-- Export:
return
  function(graph, output)
    local labels = graph[1]
    local links = graph[2]

    local num_nodes = get_num_entries(labels)
    local writer = writer.create(output, num_nodes)

    writer:start_graph()

    for index, label in ordered_pass(labels) do
      writer:node(index, label)
    end

    do
      local chains = get_chains(links)
      if (#chains == 0) then goto next end
      writer:empty_line()
      for _, chain in ipairs(chains) do
        writer:chain(chain)
      end
      :: next ::
    end

    writer:end_graph()
  end

--[[
  2026 # # # # # # # # # #
  2026-10-19
]]
