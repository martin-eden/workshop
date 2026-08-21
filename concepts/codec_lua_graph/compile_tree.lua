-- Serialize table (tree) to string with Lua code expression which recreates table

--[[
  Author: Martin Eden
  Last mod.: 2026-08-21
]]

local wrap_output
local unwrap_output
local configure_style
do
  local Initializer = request('compile.Initializer')
  wrap_output = Initializer.wrap_output
  unwrap_output = Initializer.unwrap_output
  configure_style = Initializer.configure_style
end

local get_ast = request('compile.get_tree_ast')
local serialize_ast = request('compile.serialize_tree_ast')

local compile_tree =
  function(Tree, Output, Options)
    assert_table(Tree)
    Options = Options or { }

    local original_write = wrap_output(Output)

    do
      local Settings = { }
      configure_style(Settings, Output, Options)

      serialize_ast(Settings, get_ast(Tree))
    end

    unwrap_output(Output, original_write)
  end

-- Export:
return compile_tree

--[[
  2026 #
]]
