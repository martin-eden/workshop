-- Serialize graph to .tgf format

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

--[[
  .tgf (trivial graph format) is simple and nice for code generation

  It's described at

    https://en.wikipedia.org/wiki/Trivial_Graph_Format
]]

local ascii_chars = request('!.concepts.ascii.chars')
local index_serializer = request('!.concepts.padded_index')
local output

local write_rec
do
  local field_separator = ascii_chars.space
  local record_separator = ascii_chars.newline
  local list_to_str = request('!.concepts.list.to_string')
  write_rec =
    function(rec)
      output:Write(
        list_to_str(rec, field_separator) .. record_separator
      )
    end
end

local write_label =
  function(name, label)
    write_rec({ name, label })
  end

local write_sections_delimiter
do
  local parts_delim = ascii_chars.number_sign
  write_sections_delimiter =
    function()
      write_rec({ parts_delim })
    end
end

local write_link =
  function(src_name, dest_name)
    write_rec({ src_name, dest_name })
  end

local get_node_name =
  function(index)
    return index_serializer:to_string(index)
  end

-- Export:
return
  function(graph, arg_output)
    local labels = graph[1]
    local links = graph[2]

    local num_nodes = #labels
    index_serializer = index_serializer.create(num_nodes)
    output = arg_output

    for index, label in ipairs(labels) do
      write_label(get_node_name(index), label)
    end

    write_sections_delimiter()

    for src_instruction_index = 1, #labels do
      local next_ones = links[src_instruction_index]

      if not next_ones then goto next end

      local src_name = get_node_name(src_instruction_index)

      for _, dest_instruction_index in ipairs(next_ones) do
        write_link(src_name, get_node_name(dest_instruction_index))
      end

      :: next ::
    end
  end

--[[
  2026 # # # #
  2026-10-19
]]
