-- Minimal (compact) writer of graph syntax primitives

--[[
  Author: Martin Eden
  Last mod.: 2026-08-19
]]

local space = ' '
local newline = '\n'

local Keyword_Local = function(Stream) Stream:Write('local' .. space) end
local Keyword_Return = function(Stream) Stream:Write('return' .. space) end
local EndStatement = function(Stream) Stream:Write(newline) end
local SeparateName = function(Stream) Stream:Write('.') end
local Assign = function(Stream) Stream:Write('=') end
local SeparateItem = function(Stream) Stream:Write(',') end
local StartTable = function(Stream) Stream:Write('{') end
local EndTable = function(Stream) Stream:Write('}') end
local EmptyTable = function(Stream) Stream:Write('{}') end
local StartIndex = function(Stream) Stream:Write('[') end
local EndIndex = function(Stream) Stream:Write(']') end

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
