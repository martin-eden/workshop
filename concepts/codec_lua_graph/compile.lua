-- Serialize table to string with Lua code which recreates table

--[[
  Author: Martin Eden
  Last mod.: 2026-06-20
]]

-- ( Imports
local ordered_pass = request('!.table.ordered_pass')
local get_ast = request('compile.get_ast')
local GraphSerializer = request('compile.GraphSerializer')
local formatter_minimal = request('compile.Formatters.minimal')
local formatter_readable_short = request('compile.Formatters.readable_short')
local formatter_readable_long = request('compile.Formatters.readable_long')
-- )

local set_style =
  function(style_str, GraphSerializer)
    local Formaters_Map =
      {
        ['minimal'] = formatter_minimal,
        ['readable_short'] = formatter_readable_short,
        ['readable_long'] = formatter_readable_long,
      }

    local formatter = Formaters_Map[style_str]

    if not is_function(formatter) then
      error('No formatter for given style.')
    end

    formatter(GraphSerializer.Config)
  end

--[=[
  There is syntactic clash between "long quote" and "table index":

  ['abc'] -- OK, [[[abc]]] -- NOK

  This code converts last case to "[ [[abc]]]".
]=]

local original_stream_write
local last_char = ''

local write_avoiding_syntax_clash =
  function(Output, str)
    local next_char = string.sub(str, 1, 1)

    if (last_char == '[') and (next_char == '[') then
      original_stream_write(Output, ' ')
    end

    original_stream_write(Output, str)

    last_char = string.sub(str, -1)
  end

local DefaultOptions =
  {
    style = 'readable_long',

    table_iterator = ordered_pass,
  }

local set_field =
  function(BaseTable, OptTable, field_name)
    if not is_table(OptTable) then return end
    if is_nil(OptTable[field_name]) then return end

    BaseTable[field_name] = OptTable[field_name]
  end

local compile =
  function(Graph, Output, ArgOptions)
    assert_table(Graph)

    local Options = new(DefaultOptions, ArgOptions)

    local style = Options.style

    local table_iterator = Options.table_iterator

    local Ast = get_ast(Graph, table_iterator)

    original_stream_write = Output.Write
    Output.Write = write_avoiding_syntax_clash

    do
      local GraphSerializer = new(GraphSerializer)

      local Config = GraphSerializer.Config

      Config.Output = Output

      set_style(style, GraphSerializer)

      set_field(Config, ArgOptions, 'use_compact_indices')
      set_field(Config, ArgOptions, 'use_compact_sequences')
      set_field(Config, ArgOptions, 'omit_tail_delimiter')

      GraphSerializer:SerializeGraph(Ast, Output)
    end

    Output.Write = original_stream_write
  end

-- Export:
return compile

--[[
  2016 #
  2017 #
  2018 #
  2026-06-16
  2026-06-17
  2026-06-18
  2026-06-19
  2026-06-20
]]
