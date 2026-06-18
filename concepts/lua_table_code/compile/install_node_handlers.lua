-- Serializers for Node types specific to cross-liked tables

--[[
  Author: Martin Eden
  Last mod.: 2026-06-17
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
    newline()
    emit('local ')
    compile(Node.name)
    emit(' = ')
    compile(Node.value)
  end

local serialize_index =
  function(Node)
    if
      (Node.value.type == 'string') and
      is_identifier(Node.value.value)
    then
      emit('.')
      emit(Node.value.value)
    else
      emit('[')
      compile(Node.value)
      emit(']')
    end
  end

local serialize_assignment =
  function(Node)
    newline()
    emit(Node.name)
    compile(Node.index)
    emit(' = ')
    compile(Node.value)
  end

local serialize_return_statement =
  function(Node)
    newline()
    emit('return ')
    compile(Node.value)
  end

NodeHandlers =
  {
    ['name'] = serialize_name,
    ['local_definition'] = serialize_local_definition,
    ['index'] = serialize_index,
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
]]
