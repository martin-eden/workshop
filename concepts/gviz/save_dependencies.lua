--[[
  To test save output to some file, say "test.gv",
  run "dot -Tsvg test.gv -o result.svg" and open "result.svg".
]]

return
  function()
    local result = {}
    local graph_name = 'dependencies'
    result[#result + 1] = ('digraph %s {'):format(graph_name)
    for src_name, children in pairs(_G.dependencies) do
      for dest_name in pairs(children) do
        result[#result + 1] = ('  "%s" -> "%s"'):format(src_name, dest_name)
      end
    end
    result[#result + 1] = '}'
    result = table.concat(result, '\n')
    return result
  end
