-- Serializers for Node types specific to cross-liked tables

--[[
  Author: Martin Eden
  Last mod.: 2026-06-20
]]

-- Imports:
local raw_compile = request('!.struc.compile')
local is_identifier = request('!.concepts.lua.is_identifier')
local merge = request('!.table.merge')

-- State:
local OutputStream
local NodeHandlers

-- ( Convenience wrappers
local emit =
  function(str)
    if (str == '') then return end

    OutputStream:Write(str)
  end

local newline =
  function()
    OutputStream:Write('\n')
  end

local compile =
  function(t)
    emit(raw_compile(t, NodeHandlers))
  end
-- )

local serialize_name =
  function(Node)
    compile(Node.value)
  end

local serialize_local_definition =
  function(Node)
    emit('local ')
    compile(Node.name)
    emit(' = ')
    compile(Node.Value)
    newline()
  end

local serialize_assignment =
  function(Node)
    emit(Node.name)

    -- Serialize index
    local IndexNode = Node.IndexValue
    if
      (IndexNode.type == 'string') and
      is_identifier(IndexNode.value)
    then
      emit('.')
      emit(IndexNode.value)
    else
      emit('[')
      compile(IndexNode)
      emit(']')
    end

    emit(' = ')
    compile(Node.value)
    newline()
  end

local serialize_return_statement =
  function(Node)
    emit('return ')
    compile(Node.value)
    newline()
  end

NodeHandlers =
  {
    ['name'] = serialize_name,
    ['local_definition'] = serialize_local_definition,
    ['assignment'] = serialize_assignment,
    ['return_statement'] = serialize_return_statement,
  }

return
  function(Arg_NodeHandlers, Arg_OutputStream)
    merge(Arg_NodeHandlers, NodeHandlers)

    NodeHandlers = Arg_NodeHandlers
    OutputStream = Arg_OutputStream
  end

--[[
  2018 # #
  2026-06-17
  2026-06-18
  2026-06-19
]]
