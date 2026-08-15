-- Readable (long, verbose/indented) writer of graph syntax primitives

--[[
  Author: Martin Eden
  Last mod.: 2026-08-15
]]

--[[
  Indentation is not handled here -- that remains the serializer's job
  via its own notify() mechanism, since a Writer cannot know what else
  was written to the stream between calls.
]]

local Assign = function(Me) Me:Write(' = ') end
local EmptyTable = function(Me) Me:Write('{ }') end

local Interface

local create =
  function(OutputStream)
    return Interface.internal_create(OutputStream, Interface)
  end

do
  local BaseInterface = request('Minimal')
  local patch = request('!.table.patch')

  Interface = new(BaseInterface)
  patch(
    Interface,
    {
      create = create,
      Assign = Assign,
      EmptyTable = EmptyTable,
    }
  )
end

-- Export:
return Interface

--[[
  2026-08-15
]]
