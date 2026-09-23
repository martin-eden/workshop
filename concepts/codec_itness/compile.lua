-- Write strings tree to output stream

--[[
  Author: Martin Eden
  Last mod.: 2026-09-23
]]

local DataWriter = request('compile.DataWriter.Interface')
local DelimitersWriter = request('compile.DelimitersWriter.Interface')
local Syntax = request('common.Syntax')

return
  function(Node, Output)
    local DataWriter = new(DataWriter)
    local DelimitersWriter = new(DelimitersWriter)

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

    compile(Node)

    DelimitersWriter:HandleEvent('nothing')
  end

--[[
  2024 # # #
  2026 # #
  2026-09-23
]]
