-- Serialize tree to string with Lua expression for that tree

--[[
  Author: Martin Eden
  Last mod.: 2026-08-11
]]

-- Imports:
local StringOutputStream = request('!.concepts.StreamIo.Output.String')
local compile_tree = request('!.concepts.codec_lua_graph.compile_tree')
local is_tree = request('!.table.is_tree')

local tree_to_str =
  function(Tree, Options)
    if not is_tree(Tree) then
      error('Is not tree.')
    end

    local StringStream = new(StringOutputStream)

    compile_tree(Tree, StringStream, Options)

    return StringStream:GetString()
  end

-- Export:
return tree_to_str

--[[
  2026-08-11
]]
