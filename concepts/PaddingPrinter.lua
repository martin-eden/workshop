-- Text output with padding

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

--[[
  Storage format

    1 [t] -- indent instance
    2 [t] -- output stream
]]

local inc_indent =
  function(me)
    me[1]:inc()
  end

local dec_indent =
  function(me)
    me[1]:dec()
  end

local newline
do
  local newline_char = request('!.concepts.ascii.chars').newline
  newline =
    function(me)
      me[2]:Write(newline_char)
      me[2]:Write(me[1]:to_string())
    end
end

local write =
  function(me, str)
    me[2]:Write(str)
  end

local interface
local create
do
  local indent_class = request('!.concepts.indent')
  local attach_methods = request('!.table.attach_methods')
  create =
    function(output)
      local me = { indent_class.create(), output }
      attach_methods(me, interface)
      return me
    end
end

interface =
  {
    create = create,
    IncIndent = inc_indent,
    DecIndent = dec_indent,
    Newline = newline,
    Write = write,
  }

return interface

--[[
  2026-10-20
  2026-10-22
]]
