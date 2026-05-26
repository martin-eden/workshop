-- Write strings tree to output stream

--[[
  Author: Martin Eden
  Last mod.: 2026-05-26
]]

--[[
  Contract

  Function never fails.
]]

-- Imports:
local DataWriterClass = request('Internals.DataWriter.Interface')
local DelimitersWriter = request('Internals.DelimitersWriter.Interface')

local compile_root =
  function(Tree, Output, Syntax)
    assert_table(Tree)

    local DataWriter = new(DataWriterClass)

    local compile
    compile =
      function(Node)
        if is_string(Node) then
          DelimitersWriter:HandleEvent('write_string')
          DataWriter:WriteLeaf(Node)
        elseif is_table(Node) then
          DelimitersWriter:HandleEvent('start_list')
          DataWriter:StartList()
          for _, Node in ipairs(Node) do
            compile(Node)
          end
          DelimitersWriter:HandleEvent('end_list')
          DataWriter:EndList()
        end
      end

    DataWriter.Output = Output
    DataWriter.Syntax = Syntax
    DataWriter:Init()

    DelimitersWriter.Output = Output
    DelimitersWriter.space_char = Syntax.delimiters_space_char
    DelimitersWriter.newline_char = Syntax.delimiters_newline_char
    DelimitersWriter:Init()

    for _, Node in ipairs(Tree) do
      compile(Node)
    end

    DelimitersWriter:HandleEvent('nothing')
  end

-- Export:
return compile_root

--[[
  2024 # # #
  2026-05-23
]]
