-- Implementation of "readable" Lua table serialization

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

-- Imports:
local create_base_handlers = request('base')
local raw_compile = request('!.struc.compile')
local is_name = request('!.concepts.lua.is_identifier')
local IndentClass = request('!.concepts.Indent')

-- State (
local ExistingHandlers
local OutputStream
local use_compact_sequences = true
local Indent
-- )

-- Convenience (
local emit_newline =
  function()
    OutputStream:Write('\n')
  end

local emit_indent =
  function()
    if (Indent.RangePoint.value > 0) then
      OutputStream:Write(Indent:ToString())
    end
  end

local emit =
  function(str)
    if (str == '') then return end

    OutputStream:Write(str)
  end

local compile =
  function(Tree)
    emit(raw_compile(Tree, ExistingHandlers))
  end
-- )

local serialize_table =
  function(Node)
    -- Shortcut: empty table
    if (#Node == 0) then
      emit('{ }')

      return
    end

    -- Array part tracking for <use_compact_sequences>
    local last_int_key = 0

    emit('{')

    emit_newline()

    Indent:Inc()

    for _, Rec in ipairs(Node) do
      local Key, Value = Rec.Key, Rec.Value

      emit_indent()

      --[[
        if use_compact_sequences
          Do not emit integer index while we are on array part
      ]]
      local is_on_array =
        is_integer(Key.value) and (Key.value == last_int_key + 1)

      if use_compact_sequences and is_on_array then
        last_int_key = Key.value
      else
        -- No brackets required for identifiers
        if is_name(Key.value) then
          emit(Key.value)
        else
          emit('[')
          compile(Key)
          emit(']')
        end
        emit(' = ')
      end

      compile(Value)

      emit(',')

      emit_newline()
    end

    Indent:Dec()

    emit_indent()

    emit('}')
  end

local create_node_handlers =
  function(a_ExistingHandlers, a_OutputStream, a_use_compact_sequences)
    ExistingHandlers = a_ExistingHandlers
    OutputStream = a_OutputStream

    if is_boolean(a_use_compact_sequences) then
      use_compact_sequences = a_use_compact_sequences
    end

    Indent = IndentClass.create()

    ExistingHandlers['table'] = serialize_table

    return ExistingHandlers
  end

-- Export:
return create_node_handlers

--[[
  2018 #
  2024 #
  2026 #
  2026-06-16
  2026-06-18
  2026-06-19
]]
