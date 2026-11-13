-- Serialize tree to string with Lua expression for that tree

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local string_output_stream = request('!.concepts.StreamIo.Output.String')
local compile_tree = request('!.concepts.codec_lua_graph.compile_tree')
local is_tree = request('!.table.is_tree')

return
  function(tree, options)
    assert_table(tree)

    if not is_tree(tree) then
      error('Is not tree.')
    end

    local output = string_output_stream.create()

    compile_tree(tree, output, options)

    return output:get_string()
  end

--[[
  2026-08-11
]]
