-- Write strings tree to output stream

--[[
  Author: Martin Eden
  Last mod.: 2026-10-14
]]

local Syntax = request('common.Syntax')
local DelimitersWriterClass = request('compile.DelimitersWriter')
local DataWriterClass = request('compile.DataWriter')

return
  function(Node, Output)
    local DelimitersWriter =
      DelimitersWriterClass.create(
        Syntax.delimiters_space_char,
        Syntax.delimiters_newline_char,
        Output
      )

    local DataWriter =
      DataWriterClass.create(
        {
          [1] = Syntax.delimiters_space_char,
          [2] = Syntax.delimiters_newline_char,
          [3] = Syntax.group_open_char,
          [4] = Syntax.group_close_char,
          [5] = Syntax.quote_open_char,
          [6] = Syntax.quote_close_char,
        },
        3,
        4,
        5,
        6,
        Output
      )

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

    compile(Node)

    DelimitersWriter:HandleEvent('nothing')
  end

--[[
  2024 # # #
  2026 # #
  2026-09-23
]]
