-- Serialize table to string with Lua code which recreates table

--[[
  Author: Martin Eden
  Last mod.: 2026-06-17
]]

-- Imports:
local ordered_pass = request('!.table.ordered_pass')
local patch = request('!.table.patch')
local tree_get_ast = request('!.concepts.lua_table.compile.get_ast')
local get_ast = request('compile.get_ast')
local TextBlock = request('!.mechs.text_block.interface')
local tree_get_node_handlers =
  request('!.concepts.lua_table.compile.create_node_handlers')
local install_node_handlers = request('compile.install_node_handlers')
local generic_compile = request('!.struc.compile')

local DefaultOptions =
  {
    style = 'readable',
    use_compact_sequences = true,
    serialize_only_restorable = false,
    table_iterator = ordered_pass,
  }

local compile =
  function(Graph, ArgOptions)
    assert_table(Graph)

    local Options = new(DefaultOptions)
    patch(Options, ArgOptions)

    local table_iterator = Options.table_iterator
    local serialize_only_restorable = Options.serialize_only_restorable
    local style = Options.style
    local use_compact_sequences = Options.use_compact_sequences

    local tree_get_ast =
      function(Tree, ValueNames)
        return
          tree_get_ast(
            Tree,
            table_iterator,
            serialize_only_restorable,
            ValueNames
          )
      end

    local Ast = get_ast(Graph, table_iterator, tree_get_ast)

    local TextBlock = new(TextBlock)
    TextBlock:init()

    local NodeHandlers =
      tree_get_node_handlers(TextBlock, style, use_compact_sequences)

    install_node_handlers(NodeHandlers, TextBlock)

    generic_compile(Ast, NodeHandlers)

    return TextBlock:get_text() .. '\n'
  end

-- Export:
return compile

--[[
  2016 #
  2017 #
  2026-06-17
]]
