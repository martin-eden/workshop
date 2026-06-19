-- Serialize table to string with Lua code which recreates table

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

-- Imports:
local ordered_pass = request('!.table.ordered_pass')
local patch = request('!.table.patch')
local get_ast = request('compile.get_ast')
local tree_get_node_handlers =
  request('!.concepts.lua_table.compile.create_node_handlers')
local install_node_handlers = request('compile.install_node_handlers')
local generic_compile = request('!.struc.compile')

local DefaultOptions =
  {
    style = 'readable',
    use_compact_sequences = true,
    table_iterator = ordered_pass,
  }

local compile =
  function(Graph, Output, ArgOptions)
    assert_table(Graph)

    local Options = new(DefaultOptions)
    patch(Options, ArgOptions)

    local table_iterator = Options.table_iterator
    local style = Options.style
    local use_compact_sequences = Options.use_compact_sequences

    local Ast = get_ast(Graph, table_iterator)

    local NodeHandlers =
      tree_get_node_handlers(Output, style, use_compact_sequences)

    install_node_handlers(NodeHandlers, Output)

    generic_compile(Ast, NodeHandlers)
  end

-- Export:
return compile

--[[
  2016 #
  2017 #
  2026-06-17
  2026-06-18
]]
