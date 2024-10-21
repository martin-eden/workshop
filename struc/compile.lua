-- Exotic table-to-string conversion

--[[
  Input

    Node: string or table
      if table then
        <Node.type> should be present

    NodeHandlers: table of functions
      key: <Node.type>

  Idea is to

    compile(
      { 'A', {type = 'Special', Value = 'X'}}, 'B' },
      { Special = function(Node) return ' -= ' .. Node.Value .. ' =- '}
    ) -> 'A -= X =- B'
]]

-- Last mod.: 2024-10-21

local compile_core = request('compile_core')
local ListToString = request('!.concepts.List.ToString')

return
  function(Node, NodeHandlers)
    if is_string(Node) then
      return Node
    else
      assert_table(Node)
    end

    NodeHandlers = NodeHandlers or {}
    assert_table(NodeHandlers)

    local Result = {}

    compile_core(Node, NodeHandlers, Result)
    Result = ListToString(Result)

    return Result
  end

--[[
  2017-02-13
  2017-05-09
  2017-08-27
  2018-08-08
  2024-10-21
]]
