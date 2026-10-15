-- Serialize graph to .dot format

--[[
  Author: Martin Eden
  Last mod.: 2026-10-15
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

    1 [t] labels list
      i [s] label for node at that index
    2 [t] links list
      i [t] list of adjacent nodes indices for node at given index
        0+ [i] adjecent node index
    3 [t] output stream instance
]]

local Writer = request('Writer')
local get_chains = request('!.mechs.graph.get_chains')

-- Export:
return
  function(Labels, Links, OutputStream)
    local num_nodes = #Labels
    local Writer = Writer.create(OutputStream, num_nodes)

    Writer:StartGraph()

    for index, label in ipairs(Labels) do
      Writer:Node(index, label)
    end

    Writer:EmptyLine()

    for _, Chain in ipairs(get_chains(Links)) do
      Writer:Chain(Chain)
    end

    Writer:EndGraph()
  end

--[[
  2026 # # # # # # # #
  2026-10-15
]]
