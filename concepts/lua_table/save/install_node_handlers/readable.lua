-- Implementation of "readable" Lua table serialization

local RawCompile = request('!.struc.compile')
local IsName = request('!.concepts.lua.is_identifier')

local Handlers = {}

-- State (
-- Virtual printer interface
local Printer
-- Do not emit integer indices when possible
local CompactSequences = true
-- )

-- Mostly aliasing printers methods (
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
    Emit(RawCompile(Tree, Handlers))
  end

Handlers.table =
  function(Node)
    -- Shortcut: empty table
    if (#Node == 0) then
      Emit('{}')
      return
    end

    --[[
      One-element table

      We'll put it on one line and wont write trailing delimiter.
    ]]
    local TheOneAndOnly = (#Node == 1)

    -- Array part tracking for <CompactSequences>
    local LastIntKey = 0

    Emit('{')
    Indent()

    for Idx, El in ipairs(Node) do
      local Key, Value = El.key, El.value

      if not TheOneAndOnly then
        GoToEmptyLine()
      end

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

      if not TheOneAndOnly then
        Emit(',')
      end
    end

    if not TheOneAndOnly then
      GoToEmptyLine()
    end

    Unindent()
    Emit('}')
  end

local Merge = request('!.table.merge')
local InstallMinimalHandlers = request('minimal')

-- Exports:
return
  function(a_Handlers, a_Printer, Options)
    InstallMinimalHandlers(a_Handlers, a_Printer, Options)
    Handlers = Merge(a_Handlers, Handlers)
    Printer = a_Printer
    if is_table(Options) and is_boolean(Options.compact_sequences) then
      CompactSequences = options.compact_sequences
    end
  end

--[[
  2018-02-05
  2024-08-09
]]
