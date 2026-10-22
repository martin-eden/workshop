-- Text output with padding

--[[
  Author: Martin Eden
  Last mod.: 2026-10-22
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

local write =
  function(Me, str)
    Me[2]:Write(str)
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
  2026-10-22
]]
