-- Serialize graph to .mmd (mermaid) format

--[[
  Author: Martin Eden
  Last mod.: 2026-10-19
]]

local Writer = request('Writer')
local get_chains = request('!.mechs.graph.get_chains')

-- Export:
return
  function(Graph, OutputStream)
    local Labels = Graph[1]
    local Links = Graph[2]

    local Writer = Writer.create(OutputStream, #Labels)

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
  2026-09-15
  2026-10-19
]]
