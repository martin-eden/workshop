-- .dot elements serialization

--[[
  Author: Martin Eden
  Last mod.: 2026-11-28
]]

--[[
  Internal state

    1 [t] -- tokens writer instance
    2 [t] -- padded index instance
]]

local syntels = request('writer.syntels')

local empty_line =
  function(me)
    me[1]:empty_line()
  end

local quote =
  function(str)
    return syntels.quote .. str .. syntels.quote
  end

local start_graph =
  function(me, graph_name)
    local tokens = me[1]
    tokens:write(syntels.kw_digraph)
    if graph_name then
      tokens:write(quote(graph_name))
    end
    tokens:end_line()
    tokens:write(syntels.start_graph)
    tokens:end_line()
  end

local end_graph =
  function(me)
    local tokens = me[1]
    tokens:end_line()
    tokens:write(syntels.end_graph)
    tokens:end_line()
  end

local get_node_name =
  function(me, index)
    return '_' .. me[2]:to_string(index)
  end

local node =
  function(me, index, label)
    local tokens = me[1]
    tokens:write(get_node_name(me, index))
    tokens:write(syntels.start_attr)
    tokens:write(syntels.kw_label)
    tokens:write(syntels.assign)
    tokens:write(quote(label))
    tokens:write(syntels.end_attr)
    tokens:write(syntels.end_statement)
    tokens:end_line()
  end

local chain =
  function(me, chain)
    local tokens = me[1]
    local num_nodes = #chain
    if (num_nodes <= 1) then return end
    tokens:write(get_node_name(me, chain[1]))
    for node_idx = 2, num_nodes do
      tokens:write(syntels.arrow)
      tokens:write(get_node_name(me, chain[node_idx]))
    end
    tokens:write(syntels.end_statement)
    tokens:end_line()
  end

local interface
do
  local create
  do
    local attach_methods = request('!.table.attach_methods')
    local tokens_writer = request('writer.tokens_writer')
    local index_serializer = request('!.concepts.padded_index')
    create =
      function(output, num_nodes)
        local me =
          {
            tokens_writer.create(output),
            index_serializer.create(num_nodes),
          }
        attach_methods(me, interface)
        return me
      end
  end
  interface =
    {
      create = create,
      empty_line = empty_line,
      start_graph = start_graph,
      end_graph = end_graph,
      node = node,
      chain = chain,
    }
  end

-- Export:
return interface

--[[
  2026 # # # # # #
  2026-09-15
]]
