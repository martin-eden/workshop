-- Readable (short, under-one-line) writer of graph syntax primitives

--[[
  Author: Martin Eden
  Last mod.: 2026-08-15
]]

local Assign = function(Me) Me:Write(' = ') end
local SeparateItem = function(Me) Me:Write(', ') end
local StartTable = function(Me) Me:Write('{ ') end
local EndTable = function(Me) Me:Write(' }') end
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
      SeparateItem = SeparateItem,
      StartTable = StartTable,
      EndTable = EndTable,
      EmptyTable = EmptyTable,
    }
  )
end

-- Export:
return Interface

--[[
  2026-08-15
]]
