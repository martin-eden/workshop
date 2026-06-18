-- Implementation of "readable" Lua table serialization

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

-- Imports:
local CreateBaseHandlers = request('base')
local RawCompile = request('!.struc.compile')
local IsName = request('!.concepts.lua.is_identifier')

-- State (
-- Node handlers
local ExistingHandlers
-- Virtual printer interface
local Printer
-- Do not emit integer indices when possible
local CompactSequences = true
-- )

-- Aliasing printer's methods (
local GoToEmptyLine =
  function()
    Printer:request_clean_line()
  end

local Indent =
  function()
    Printer:inc_indent()
  end

local Unindent =
  function()
    Printer:dec_indent()
  end

local Emit =
  function(s)
    Printer:add_curline(s)
  end
-- )

local Compile =
  function(Tree)
    Emit(RawCompile(Tree, ExistingHandlers))
  end

local SerializeTable =
  function(Node)
    -- Shortcut: empty table
    if (#Node == 0) then
      Emit('{ }')

      return
    end

    -- Array part tracking for <CompactSequences>
    local LastIntKey = 0

    Emit('{')
    Indent()

    for _, Rec in ipairs(Node) do
      local Key, Value = Rec.Key, Rec.Value

      GoToEmptyLine()

      --[[
        if CompactSequences
          Do not emit integer index while we are on array part
      ]]
      local IsOnArray =
        is_integer(Key.value) and (Key.value == LastIntKey + 1)

      if CompactSequences and IsOnArray then
        LastIntKey = Key.value
      else
        -- No brackets required for identifiers
        if IsName(Key.value) then
          Emit(Key.value)
        else
          Emit('[')
          Compile(Key)
          Emit(']')
        end
        Emit(' = ')
      end

      Compile(Value)

      Emit(',')
    end

    GoToEmptyLine()

    Unindent()
    Emit('}')
  end

local CreateNodeHandlers =
  function(a_ExistingHandlers, a_Printer, a_CompactSequences)
    ExistingHandlers = a_ExistingHandlers
    Printer = a_Printer

    if is_boolean(a_CompactSequences) then
      CompactSequences = a_CompactSequences
    end

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
]]
