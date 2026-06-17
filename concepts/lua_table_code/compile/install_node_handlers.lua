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
local TextBlock
local NodeHandlers

-- ( Convenience wrappers
local add =
  function(s)
    TextBlock:add_curline(s)
  end

local request_clean_line =
  function()
    TextBlock:request_clean_line()
  end

local compile =
  function(t)
    add(raw_compile(t, NodeHandlers))
  end
-- )

local serialize_name =
  function(Node)
    compile(Node.value)
  end

local serialize_local_definition =
  function(Node)
    request_clean_line()
    add('local ')
    compile(Node.name)
    add(' = ')
    compile(Node.value)
  end

local serialize_index =
  function(Node)
    if
      (Node.value.type == 'string') and
      is_identifier(Node.value.value)
    then
      add('.')
      add(Node.value.value)
    else
      add('[')
      compile(Node.value)
      add(']')
    end
  end

local serialize_assignment =
  function(Node)
    request_clean_line()
    add(Node.name)
    compile(Node.index)
    add(' = ')
    compile(Node.value)
  end

local serialize_return_statement =
  function(Node)
    request_clean_line()
    add('return ')
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
  function(Arg_NodeHandlers, Arg_TextBlock)
    merge(Arg_NodeHandlers, NodeHandlers)

    NodeHandlers = Arg_NodeHandlers
    TextBlock = Arg_TextBlock
  end

--[[
  2018 # #
  2026-06-17
]]
