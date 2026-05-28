-- Serialize module dependencies map to GraphViz string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')
local lines_to_str = request('!.convert.lines_to_str')

--[[
  Test

  * Save output string to "test.gv"
  * $ dot -Tsvg test.gv -o result.svg
  * Open "result.svg"
]]

local save_dependencies =
  function(Dependencies_Map)
    local Lines = { }

    local graph_name = 'dependencies'
    local header_str = ('digraph %s {'):format(graph_name)
    add_to_list(Lines, header_str)

    for src_name, Children in pairs(Dependencies_Map) do
      for dest_name in pairs(Children) do
        local dependency_str =
          ('  "%s" -> "%s"'):format(src_name, dest_name)
        add_to_list(Lines, dependency_str)
      end
    end

    add_to_list(Lines, '}')

    return lines_to_str(Lines)
  end

-- Export:
return save_dependencies

--[[
  2016
  2026-05-29
]]
