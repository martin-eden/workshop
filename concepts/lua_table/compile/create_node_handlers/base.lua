-- Return minimal table serializer methods

--[[
  Author: Martin Eden
  Last mod.: 2026-06-17
]]

--[[
  Result string with table definition does not contain any
  optional spaces or newlines.

  So code is human-unreadable.
]]

-- Imports:
local raw_compile = request('!.struc.compile')
local quote = request('!.lua.string.quote')
local string_starts_with = request('!.string.starts_with')
local string_ends_with = request('!.string.ends_with')
local is_identifier = request('!.concepts.lua.is_identifier')

-- Internal state:
local NodeHandlers
local TextBlock
local use_compact_sequences = true

local emit =
  function(str)
    TextBlock:add_curline(str)
  end

local compile =
  function(t)
    emit(raw_compile(t, NodeHandlers))
  end

local is_pos_inf = function(n) return (n == 1 / 0) end
local is_neg_inf = function(n) return (n == -1 / 0) end
local is_nan = function(n) return (n ~= n) end

--[[
  tostring() of number, beyond orthodoxal values, can return
  "-nan", "inf" and "-inf".

  They are not loadable.

  If number has one of those special values we emit expression
  that produce those special value.
]]
local serialize_number =
  function(Node)
    local n = Node.value

    if is_pos_inf(n) then
      emit('1/0')
    elseif is_neg_inf(n) then
      emit('-1/0')
    elseif is_nan(n) then
      emit('0/0')
    else
      emit(tostring(Node.value))
    end
  end

local serialize_tostring =
  function(Node)
    emit(tostring(Node.value))
  end

local serialize_quote =
  function(Node)
    local quoted_string = quote(tostring(Node.value))

    --[=[
      There is syntactic clash between "long quote" and "table index":

      ['abc'] -- OK, [[[abc]]] -- NOK

      This code converts last case to "[ [[abc]]]".
    ]=]
    if
      string_starts_with(quoted_string, '[') and
      not TextBlock:on_clean_line() and
      string_ends_with(TextBlock.line_with_text:get_line(), '[')
    then
      emit(' ')
    end

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

      local Key = Node[i].key
      local Value = Node[i].value

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
    ['nil'] = serialize_tostring,
    ['boolean'] = serialize_tostring,
    ['number'] = serialize_number,
    ['string'] = serialize_quote,
    ['table'] = serialize_table,
    ['function'] = serialize_quote,
    ['thread'] = serialize_quote,
    ['userdata'] = serialize_quote,
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
  2017-05
  2019-06
  2026-06-16
]]
