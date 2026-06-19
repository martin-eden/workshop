-- Serialize tree to string with Lua table definition

--[[
  Author: Martin Eden
  Last mod.: 2026-06-16
]]

-- Not suitable for tables with cross-links in keys or values.

-- ( Imports
local ordered_pass = request('!.table.ordered_pass')
local generic_compile = request('!.struc.compile')

local create_node_handlers = request('compile.create_node_handlers')
local get_ast = request('compile.get_ast')
-- )

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
  function(Tree, Output, ArgOptions)
    assert_table(Tree)

    original_stream_write = Output.Write
    Output.Write = write_avoiding_syntax_clash

    local Options = new(DefaultOptions, ArgOptions)

    local table_iterator = Options.table_iterator
    local style = Options.style
    local use_compact_sequences = Options.use_compact_sequences

    local Ast = get_ast(Tree, table_iterator, {})

    local NodeHandlers =
      create_node_handlers(Output, style, use_compact_sequences)

    generic_compile(Ast, NodeHandlers)

    Output.Write = original_stream_write

    Output:Write('\n')
  end

-- Export:
return compile

--[[
  2016 #
  2017 #
  2018 #
  2026-06-16
  2026-06-19
]]
