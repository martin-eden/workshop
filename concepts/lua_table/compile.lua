-- Serialize tree to string with Lua table definition

--[[
  Author: Martin Eden
  Last mod.: 2026-06-16
]]

-- Not suitable for tables with cross-links in keys or values.

-- ( Imports
local ordered_pass = request('!.table.ordered_pass')
local patch = request('!.table.patch')
local TextBlock = request('!.mechs.text_block.interface')
local generic_compile = request('!.struc.compile')

local create_node_handlers = request('compile.create_node_handlers')
local get_ast = request('compile.get_ast')
-- )

local DefaultOptions =
  {
    style = 'readable',
    use_compact_sequences = true,
    serialize_only_restorable = false,
    table_iterator = ordered_pass,
  }

local compile =
  function(Tree, ArgOptions)
    assert_table(Tree)

    local Options = new(DefaultOptions)
    patch(Options, ArgOptions)

    local table_iterator = Options.table_iterator
    local serialize_only_restorable = Options.serialize_only_restorable
    local style = Options.style
    local use_compact_sequences = Options.use_compact_sequences

    local Ast =
      get_ast(Tree, table_iterator, serialize_only_restorable, {})

    local TextBlock = new(TextBlock)
    TextBlock:init()

    local NodeHandlers =
      create_node_handlers(TextBlock, style, use_compact_sequences)

    generic_compile(Ast, NodeHandlers)

    return TextBlock:get_text() .. '\n'
  end

-- Export:
return compile

--[[
  2016 #
  2017 #
  2018 #
  2026-06-16
]]
