-- Serialize table (tree) to string with Lua code expression which recreates table

--[[
  Author: Martin Eden
  Last mod.: 2026-08-11
]]

local Initializer = request('compile.Initializer')
local TreeSerializer = request('compile.TreeSerializer')
local GetTreeAst = request('compile.GetTreeAst')

local compile_tree =
  function(Tree, Output, ArgOptions)
    assert_table(Tree)

    local Options = new(Initializer.DefaultOptions, ArgOptions)

    local original_write = Initializer.wrap_output(Output)

    do
      local TreeSerializer = new(TreeSerializer)

      Initializer.configure_style(TreeSerializer, Options.style, ArgOptions)

      local Ast = GetTreeAst.get_tree_ast(Tree, Options.table_iterator)

      TreeSerializer:SerializeTree(Ast, Output)
    end

    Initializer.unwrap_output(Output, original_write)
  end

-- Export:
return compile_tree

--[[
  2026-08-11
]]
