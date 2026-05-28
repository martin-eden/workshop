-- Serialize module dependencies map to GraphViz string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

--[[
  Test

  * Save output string to "result.gv"
  * $ dot -Tsvg result.gv -o result.svg
  * Open "result.svg"
]]

-- Imports:
local split_string = request('!.string.split')
local add_to_list = request('!.concepts.list.add_item')
local lines_to_str = request('!.convert.lines_to_str')

local trim_module_name =
  function(module_name)
    local NameParts = split_string(module_name, '.')

    return NameParts[#NameParts]
  end

local get_node_style_str =
  function(node_name)
    local trimmed_name = trim_module_name(node_name)

    local style_str =
      string.format(
        '  "%s" [label=%q];',
        node_name,
        trimmed_name
      )

    return style_str
  end


local save_dependencies =
  function(Dependencies_Map)
    local Lines = { }

    local UsedNodes_Map = { }

    local graph_name = 'dependencies'
    local header_str = ('digraph %s {'):format(graph_name)
    add_to_list(Lines, header_str)

    for src_name, Children in pairs(Dependencies_Map) do
      if not UsedNodes_Map[src_name] then
        add_to_list(Lines, get_node_style_str(src_name))

        UsedNodes_Map[src_name] = true
      end

      local trimmed_src_name = trim_module_name(src_name)

      for dest_name in pairs(Children) do
        if not UsedNodes_Map[dest_name] then
          add_to_list(Lines, get_node_style_str(dest_name))

          UsedNodes_Map[dest_name] = true
        end
        local trimmed_dest_name = trim_module_name(dest_name)
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
