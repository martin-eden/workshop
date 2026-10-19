-- Serialize graph to .dot format

--[[
  Author: Martin Eden
  Last mod.: 2026-10-19
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
local Writer = request('Writer')
local ordered_pass = request('!.table.ordered_pass')
local get_chains = request('!.mechs.graph.get_chains')

-- Export:
return
  function(Graph, OutputStream)
    local Labels = Graph[1]
    local Links = Graph[2]

    local num_nodes = get_num_entries(Labels)
    local Writer = Writer.create(OutputStream, num_nodes)

    Writer:StartGraph()

    for index, label in ordered_pass(Labels) do
      Writer:Node(index, label)
    end

    do
      local Chains = get_chains(Links)

      if (#Chains == 0) then goto next end

      Writer:EmptyLine()

      for _, Chain in ipairs(Chains) do
        Writer:Chain(Chain)
      end

      :: next ::
    end

    Writer:EndGraph()
  end

--[[
  2026 # # # # # # # # # #
  2026-10-19
]]
