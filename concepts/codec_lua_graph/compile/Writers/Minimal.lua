-- Minimal (compact) writer of graph syntax primitives

--[[
  Author: Martin Eden
  Last mod.: 2026-08-15
]]

local space = ' '
local newline = '\n'

local Keyword_Local = function(Me) Me:Write('local' .. space) end
local Keyword_Return = function(Me) Me:Write('return' .. space) end
local EndStatement = function(Me) Me:Write(newline) end
local SeparateName = function(Me) Me:Write('.') end
local Assign = function(Me) Me:Write('=') end
local SeparateItem = function(Me) Me:Write(',') end
local StartTable = function(Me) Me:Write('{') end
local EndTable = function(Me) Me:Write('}') end
local EmptyTable = function(Me) Me:Write('{}') end
local StartIndex = function(Me) Me:Write('[') end
local EndIndex = function(Me) Me:Write(']') end

local Interface

local create =
  function(OutputStream)
    return Interface.internal_create(OutputStream, Interface)
  end

do
  local BaseInterface = request('Interface')
  local patch = request('!.table.patch')

  Interface = new(BaseInterface)
  patch(
    Interface,
    {
      create = create,

      Keyword_Local = Keyword_Local,
      SeparateName = SeparateName,
      EndStatement = EndStatement,
      Keyword_Return = Keyword_Return,

      Assign = Assign,
      SeparateItem = SeparateItem,
      StartTable = StartTable,
      EndTable = EndTable,
      EmptyTable = EmptyTable,
      StartIndex = StartIndex,
      EndIndex = EndIndex,
    }
  )
end

-- Export:
return Interface

--[[
  2026-08-15
]]
