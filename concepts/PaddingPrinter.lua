-- Text output with padding

--[[
  Author: Martin Eden
  Last mod.: 2026-10-20
]]

--[[
  Storage format
    1 [t] indent instance
    2 [t] output stream
]]

local inc_indent =
  function(Me)
    Me[1]:Inc()
  end

local dec_indent =
  function(Me)
    Me[1]:Dec()
  end

local newline
do
  local newline_char = request('!.concepts.Ascii.Chars').newline
  newline =
    function(Me)
      Me[2]:Write(newline_char)
      Me[2]:Write(Me[1]:ToString())
    end
end

local write
do
  local it_lines = request('!.string.lines')
  write =
    function(Me, str)
      local is_first_line = true
      for _, line in it_lines(str) do
        if not is_first_line then
          newline(Me)
        end
        Me[2]:Write(line)
        is_first_line = false
      end
    end
end

local Interface
local create
do
  local IndentClass = request('!.concepts.Indent')
  local attach_methods = request('!.table.attach_methods')
  create =
    function(Output)
      local Me = { IndentClass.create(), Output }
      attach_methods(Me, Interface)
      return Me
    end
end

Interface =
  {
    create = create,
    IncIndent = inc_indent,
    DecIndent = dec_indent,
    Newline = newline,
    Write = write,
  }

return Interface

--[[
  2026-10-20
]]
