-- Serialize table to string with Lua code which recreates table

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

-- Imports:
local ordered_pass = request('!.table.ordered_pass')
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

local last_char = ''
local original_stream_write

local write_avoiding_syntax_clash =
  function(Me, str)
    local next_char = string.sub(str, 1, 1)

    if (last_char == '[') and (next_char == '[') then
      original_stream_write(Me, ' ')
    end

    original_stream_write(Me, str)

    last_char = string.sub(str, -1)
  end

local compile =
  function(Graph, Output, ArgOptions)
    assert_table(Graph)

    original_stream_write = Output.Write
    Output.Write = write_avoiding_syntax_clash

    local Options = new(DefaultOptions, ArgOptions)

    local table_iterator = Options.table_iterator
    local style = Options.style
    local use_compact_sequences = Options.use_compact_sequences

    local Ast = get_ast(Graph, table_iterator)

    local NodeHandlers =
      tree_get_node_handlers(Output, style, use_compact_sequences)

    install_node_handlers(NodeHandlers, Output)

    generic_compile(Ast, NodeHandlers)

    Output.Write = original_stream_write
  end

-- Export:
return compile

--[[
  2016 #
  2017 #
  2026-06-17
  2026-06-18
  2026-06-19
]]
