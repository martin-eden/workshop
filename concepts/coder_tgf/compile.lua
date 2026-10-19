-- Serialize graph to .tgf format

--[[
  Author: Martin Eden
  Last mod.: 2026-10-19
]]

--[[
  .tgf (trivial graph format) is simple and nice for code generation

  It's described at

    https://en.wikipedia.org/wiki/Trivial_Graph_Format
]]

local AsciiChars = request('!.concepts.Ascii.Chars')
local IndexSerializer = request('!.concepts.PaddedIndex')
local OutputStream

local write_rec
do
  local field_separator = AsciiChars.space
  local record_separator = AsciiChars.newline
  local list_to_str = request('!.concepts.list.to_string')
  write_rec =
    function(Rec)
      OutputStream:Write(
        list_to_str(Rec, field_separator) .. record_separator
      )
    end
end

local write_label =
  function(name, label)
    write_rec({ name, label })
  end

local write_sections_delimiter
do
  local parts_delim = AsciiChars.number_sign
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
    return IndexSerializer:ToString(index)
  end

-- Export:
return
  function(Graph, Arg_OutputStream)
    local Labels = Graph[1]
    local Links = Graph[2]

    local num_nodes = #Labels
    IndexSerializer = IndexSerializer.create(num_nodes)
    OutputStream = Arg_OutputStream

    for index, label in ipairs(Labels) do
      write_label(get_node_name(index), label)
    end

    write_sections_delimiter()

    for src_instruction_index = 1, #Labels do
      local NextOnes = Links[src_instruction_index]

      if not NextOnes then goto next end

      local src_name = get_node_name(src_instruction_index)

      for _, dest_instruction_index in ipairs(NextOnes) do
        write_link(src_name, get_node_name(dest_instruction_index))
      end

      :: next ::
    end
  end

--[[
  2026 # # # #
  2026-10-19
]]
