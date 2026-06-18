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
local should_write_indent = true
-- )

-- Aliasing printer's methods (
local newline =
  function()
    OutputStream:Write('\n')

    should_write_indent = true
  end

local emit =
  function(str)
    if (str == '') then return end

    if should_write_indent then
      if (Indent.RangePoint.value > 0) then
        OutputStream:Write(Indent:ToString())
      end

      should_write_indent = false
    end

    OutputStream:Write(str)
  end
-- )

local Compile =
  function(Tree)
    emit(raw_compile(Tree, ExistingHandlers))
  end

local SerializeTable =
  function(Node)
    -- Shortcut: empty table
    if (#Node == 0) then
      emit('{ }')

      return
    end

    -- Array part tracking for <use_compact_sequences>
    local last_int_key = 0

    emit('{')
    Indent:Inc()

    for _, Rec in ipairs(Node) do
      local Key, Value = Rec.Key, Rec.Value

      newline()

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
          Compile(Key)
          emit(']')
        end
        emit(' = ')
      end

      Compile(Value)

      emit(',')
    end

    newline()

    Indent:Dec()
    emit('}')
  end

local CreateNodeHandlers =
  function(a_ExistingHandlers, a_OutputStream, a_use_compact_sequences)
    ExistingHandlers = a_ExistingHandlers
    OutputStream = a_OutputStream

    if is_boolean(a_use_compact_sequences) then
      use_compact_sequences = a_use_compact_sequences
    end

    Indent = IndentClass.create()

    ExistingHandlers['table'] = SerializeTable

    return ExistingHandlers
  end

-- Export:
return CreateNodeHandlers

--[[
  2018-02-05
  2024-08-09
  2026-05-03
  2026-06-16
  2026-06-18
]]
