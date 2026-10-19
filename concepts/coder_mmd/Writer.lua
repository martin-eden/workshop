-- .mmd elements serialization

--[[
  Author: Martin Eden
  Last mod.: 2026-09-15
]]

--[[
  Internal state

    1 [t] -- tokens writer instance
    2 [t] -- indent instance
    3 [t] -- padded index instance
]]

local Syntels = request('Writer.Syntels')

local EmptyLine =
  function(Me)
    Me[1]:EmptyLine()
  end

local quote
do
  local quote_str = Syntels.quote
  quote =
    function(str)
      return quote_str .. str .. quote_str
    end
end

local StartGraph
do
  local flowchart = Syntels.kw_flowchart
  local topdown = Syntels.topdown
  StartGraph =
    function(Me)
      local Tokens = Me[1]
      Tokens:Write(flowchart)
      Tokens:Write(topdown)
      Tokens:EndLine()
    end
end

local EndGraph =
  function(Me)
    Me[1]:EndLine()
  end

local get_node_name
do
  local name_prefix = '_'
  get_node_name =
    function(Me, index)
      return name_prefix .. Me[2]:ToString(index)
    end
end

local Node
do
  local start_attr = Syntels.start_attr
  local end_attr = Syntels.end_attr
  Node =
    function(Me, index, label)
      local Tokens = Me[1]
      Tokens:Write(get_node_name(Me, index))
      Tokens:Write(start_attr)
      Tokens:Write(quote(label))
      Tokens:Write(end_attr)
      Tokens:EndLine()
    end
end

local Chain
do
  local arrow = Syntels.arrow
  Chain =
    function(Me, Chain)
      local Tokens = Me[1]

      local num_nodes = #Chain
      if (num_nodes <= 1) then return end

      Tokens:Write(get_node_name(Me, Chain[1]))
      for node_idx = 2, num_nodes do
        Tokens:Write(arrow)
        Tokens:Write(get_node_name(Me, Chain[node_idx]))
      end
      Tokens:EndLine()
    end
end

local Methods
do
  local create
  do
    local attach_methods = request('!.table.attach_methods')
    local TokensWriter = request('Writer.TokensOutputStream')
    local IndexSerializer = request('!.concepts.PaddedIndex')
    create =
      function(OutputStream, num_nodes)
        local Core =
          {
            [1] = TokensWriter.create(OutputStream),
            [2] = IndexSerializer.create(num_nodes),
          }
        attach_methods(Core, Methods)

        return Core
      end
  end

  Methods =
    {
      create = create,

      EmptyLine = EmptyLine,

      StartGraph = StartGraph,
      EndGraph = EndGraph,

      Node = Node,
      Chain = Chain,
    }
  end

-- Export:
return Methods

--[[
  2026-09-15
]]
