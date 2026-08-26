-- Serialize table (tree) to string with Lua expression that recreates table

--[[
  Author: Martin Eden
  Last mod.: 2026-08-27
]]

local initialize = request('compile.initialize')
local get_ast = request('compile.get_tree_ast')
local serialize_ast = request('compile.serialize_tree_ast')

-- Export:
return
  function(Tree, Output, Options)
    assert_table(Tree)
    Options = Options or { }

    local Settings = { }
    initialize(Settings, Output, Options)

    serialize_ast(Settings, get_ast(Tree))
  end

--[[
  2026 #
]]
