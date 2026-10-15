-- .dot elements serialization

--[[
  Author: Martin Eden
  Last mod.: 2026-10-15
]]

--[[
  Internal state

    1 [t] -- tokens writer instance
    2 [t] -- padded index instance
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
  local digraph = Syntels.kw_digraph
  local start_graph = Syntels.start_graph
  StartGraph =
    function(Me, graph_name)
      local Tokens = Me[1]
      Tokens:Write(digraph)
      if graph_name then
        Tokens:Write(quote(graph_name))
      end
      Tokens:EndLine()
      Tokens:Write(start_graph)
      Tokens:EndLine()
    end
end

local EndGraph
do
  local end_graph = Syntels.end_graph
  EndGraph =
    function(Me)
      local Tokens = Me[1]
      Tokens:EndLine()
      Tokens:Write(end_graph)
      Tokens:EndLine()
    end
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
  local label_kw = Syntels.kw_label
  local assign = Syntels.assign
  local end_statement = Syntels.end_statement
  Node =
    function(Me, index, label)
      local Tokens = Me[1]
      Tokens:Write(get_node_name(Me, index))
      Tokens:Write(start_attr)
      Tokens:Write(label_kw)
      Tokens:Write(assign)
      Tokens:Write(quote(label))
      Tokens:Write(end_attr)
      Tokens:Write(end_statement)
      Tokens:EndLine()
    end
end

local Chain
do
  local arrow = Syntels.arrow
  local end_statement = Syntels.end_statement
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
      Tokens:Write(end_statement)
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
  2026 # # # # # #
  2026-09-15
]]
