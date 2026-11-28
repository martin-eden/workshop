-- Serialize graph to .mmd (mermaid) format

--[[
  Author: Martin Eden
  Last mod.: 2026-11-28
]]

local writer = request('writer')
local get_chains = request('!.mechs.graph.get_chains')

return
  function(graph, output)
    local labels = graph[1]
    local links = graph[2]

    local writer = writer.create(output, #labels)

    writer:start_graph()

    for index, label in ipairs(labels) do
      writer:node(index, label)
    end

    writer:empty_line()

    for _, chain in ipairs(get_chains(links)) do
      writer:chain(chain)
    end

    writer:end_graph()
  end

--[[
  2026 # #
]]
