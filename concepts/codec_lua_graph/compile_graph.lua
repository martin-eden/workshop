-- Serialize table to string with Lua code which recreates table

--[[
  Author: Martin Eden
  Last mod.: 2026-08-11
]]

local Initializer = request('compile.Initializer')
local GraphSerializer = request('compile.GraphSerializer')
local get_ast = request('compile.get_ast')

local compile_graph =
  function(Graph, Output, ArgOptions)
    assert_table(Graph)

    local Options = new(Initializer.DefaultOptions, ArgOptions)

    local original_write = Initializer.wrap_output(Output)

    do
      local GraphSerializer = new(GraphSerializer)

      Initializer.configure_style(GraphSerializer, Options.style, ArgOptions)

      local Ast = get_ast(Graph, Options.table_iterator)

      GraphSerializer:SerializeGraph(Ast, Output)
    end

    Initializer.unwrap_output(Output, original_write)
  end

-- Export:
return compile_graph

--[[
  2016 #
  2017 #
  2018 #
  2026-06 # # # # #
  2026-08-11
]]
