-- Serialize table (graph) to string with Lua code that recreates table

--[[
  Author: Martin Eden
  Last mod.: 2026-08-27
]]

local initialize = request('compile.initialize')
local get_ast = request('compile.get_graph_ast')
local serialize_ast = request('compile.serialize_graph_ast')

-- Export:
return
  function(Graph, Output, Options)
    assert_table(Graph)
    Options = Options or { }

    local Settings = { }
    initialize(Settings, Output, Options)

    serialize_ast(Settings, get_ast(Graph))
  end

--[[
  2016 #
  2017 #
  2018 #
  2026 # # # # # # #
]]
