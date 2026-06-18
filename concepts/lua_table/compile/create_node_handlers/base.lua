-- Return minimal table serializer methods

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

--[[
  Result string with table definition does not contain any
  optional spaces or newlines.

  So code is human-unreadable.
]]

--[=[
  There is syntactic clash between "long quote" and "table index":

  ['abc'] -- OK, [[[abc]]] -- NOK

  This code converts last case to "[ [[abc]]]".
]=]

-- Imports:
local raw_compile = request('!.struc.compile')
local quote = request('!.lua.string.quote')
local is_identifier = request('!.concepts.lua.is_identifier')

-- Internal state:
local NodeHandlers
local TextBlock
local use_compact_sequences = true
local last_char = ''

-- ( Wrappers
local emit =
  function(str)
    TextBlock:add_curline(str)

    last_char = string.sub(str, -1)
  end

local compile =
  function(t)
    emit(raw_compile(t, NodeHandlers))
  end
-- )

local serialize_terminal_value =
  function(Node)
    -- Imported here to remove cycle dependency at load
    local value_to_str = request('!.convert.value_to_str')

    emit(value_to_str(Node.value))
  end

local serialize_as_string =
  function(Node)
    -- Imported here to remove cycle dependency at load
    local value_to_str = request('!.convert.value_to_str')

    local quoted_string = value_to_str(Node.value)

    local next_char = string.sub(quoted_string, 1, 1)

    if (last_char == '[') and (next_char == '[') then emit(' ') end

    emit(quoted_string)
  end

local serialize_table =
  function(Node)
    if (#Node == 0) then
      emit('{}')

      return
    end

    local last_integer_key = 0

    emit('{')

    for i = 1, #Node do
      if (i > 1) then emit(',') end

      local Key = Node[i].Key
      local Value = Node[i].Value

      -- Serialize key
      do
        local skip_key_serialization =
          use_compact_sequences and
          (Key.type == 'number') and
          is_integer(Key.value) and
          (Key.value == last_integer_key + 1)

        if skip_key_serialization then
          last_integer_key = Key.value

          goto end_key_processing
        end

        local brackets_not_required =
          (Key.type == 'string') and is_identifier(Key.value)

        if brackets_not_required then
          emit(Key.value)
        else
          emit('[')
          compile(Key)
          emit(']')
        end
        emit('=')

        :: end_key_processing ::
      end

      -- Serialize value
      compile(Value)
    end

    emit('}')
  end

NodeHandlers =
  {
    ['nil'] = serialize_terminal_value,
    ['boolean'] = serialize_terminal_value,
    ['number'] = serialize_terminal_value,
    ['string'] = serialize_as_string,

    ['table'] = serialize_table,

    ['function'] = serialize_as_string,
    ['thread'] = serialize_as_string,
    ['userdata'] = serialize_as_string,
  }

local get_node_handlers =
  function(Arg_TextBlock, arg_use_compact_sequences)
    TextBlock = Arg_TextBlock

    if is_boolean(arg_use_compact_sequences) then
      use_compact_sequences = arg_use_compact_sequences
    end

    return NodeHandlers
  end

-- Export:
return get_node_handlers

--[[
  2017 #
  2019 #
  2026-06-16
  2026-06-18
]]
