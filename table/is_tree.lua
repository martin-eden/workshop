-- Function to check that table is tree

--[[
  Author: Martin Eden
  Last mod.: 2025-03-30
]]

--[[
  Check that table is tree, i.e. each node can be reached only one way

  Examples:

    t = { a = { 'B' } } -- OK

    t = { a = { 'B' } }
    t.b = t.a -- FAIL, DAG, not tree

    t = { a = { 'B' } }
    t.b = t -- FAIL, graph with cycle
]]
local IsTree =
  function(Tree)
    assert_table(Tree)

    local VisitedNodes = {}
    local Result = true

    local ProcessNode
    ProcessNode =
      function(Node)
        if not is_table(Node) then
          return
        end

        if VisitedNodes[Node] then
          Result = false
          return
        end

        VisitedNodes[Node] = true

        for _, Value in pairs(Node) do
          ProcessNode(Value)
        end
      end

    ProcessNode(Tree)

    return Result
  end

-- Exports:
return IsTree

--[[
  2025-03-30
]]
