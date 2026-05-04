-- Exotic table-to-string conversion

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

--[[
  Input

    Node: string or table
      if table then
        <Node.type> should be present

    NodeHandlers: table of functions
      key: <Node.type>

  Idea is to call serializing functions when <.type> is set:

    compile
      { 'A', { type = 'Special', Value = 'X' } }, 'B' },
      { Special = function(Node) return ' -= ' .. Node.Value .. ' =- ' end }
      ->
      'A -= X =- B'
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')
local list_to_string = request('!.concepts.list.to_string')

-- Execute node handlers for tree nodes. Collect results
local compile
compile =
  function(Node, NodeHandlers, Result)
    if is_string(Node) then
      add_to_list(Result, Node)
    elseif is_table(Node) then
      local node_handler = NodeHandlers[Node.type]

      if Node.type and not node_handler then
        local msg =
          string.format('No node handler for type "%s".', Node.type)

        io.stderr:write(msg)
      end

      if node_handler then
        add_to_list(Result, node_handler(Node))
      else
        for idx, SubNode in ipairs(Node) do
          compile(SubNode, NodeHandlers, Result)
        end
      end
    end
  end

local compile_root =
  function(Node, NodeHandlers)
    if is_string(Node) then
      return Node
    else
      assert_table(Node)
    end

    NodeHandlers = NodeHandlers or { }
    assert_table(NodeHandlers)

    local Result = { }

    compile(Node, NodeHandlers, Result)

    return list_to_string(Result)
  end

-- Export:
return compile_root

--[[
  2017 # # #
  2018 #
  2024 #
  2026-05-04
]]
