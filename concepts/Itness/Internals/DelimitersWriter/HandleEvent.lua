-- Delimiters writer. Event handler

--[[
  Author: Martin Eden
  Last mod.: 2026-05-23
]]

-- Write string. Update empty line state
local Emit =
  function(Me, str)
    Me.Output:Write(str)
    Me.is_on_empty_line = false
  end

-- Assure that next string will be written on new line
local EmitNewline =
  function(Me)
    if Me.is_on_empty_line then return end
    Emit(Me, Me.newline_char)
    Me.is_on_empty_line = true
  end

-- Emit indentation string
local EmitIndent =
  function(Me)
    Emit(Me, Me.Indent:ToString())
  end

-- Write newline and indentation
local EmitNewlineIndent =
  function(Me)
    EmitNewline(Me)
    EmitIndent(Me)
  end

-- ( Delimiting functions

local EmptyFunc =
  function(Me)
  end

local NewlineFunc =
  function(Me)
    EmitNewline(Me)
  end

local NewlineIndentFunc =
  function(Me)
    EmitNewlineIndent(Me)
  end

local SpaceFunc =
  function(Me)
    Emit(Me, Me.space_char)
  end

-- ) Delimiting functions

--[[
  Decision matrix

  Return delimiting function given previous and current events.
]]
local EventsToFunc =
  {
    ['nothing'] =
      {
        ['nothing'] = EmptyFunc,
        ['write_string'] = EmptyFunc,
        ['start_list'] = EmptyFunc,
        ['end_list'] = EmptyFunc,
      },
    ['write_string'] =
      {
        ['nothing'] = EmptyFunc,
        ['write_string'] = SpaceFunc,
        ['start_list'] = NewlineIndentFunc,
        ['end_list'] = SpaceFunc,
      },
    ['start_list'] =
      {
        ['nothing'] = EmptyFunc,
        ['write_string'] = SpaceFunc,
        ['start_list'] = NewlineIndentFunc,
        ['end_list'] = EmptyFunc,
      },
    ['end_list'] =
      {
        ['nothing'] = NewlineIndentFunc,
        ['write_string'] = NewlineIndentFunc,
        ['start_list'] = NewlineIndentFunc,
        ['end_list'] = NewlineIndentFunc,
      },
  }

--[[
  Write delimiters between items

  Should be called before writing non-delimiting element.

  Delimiter depends of previous and current item types.

  Input

    Me [t]
    event_name [s] -- event name:
      ( nothing start_list write_string end_list )
]]
local OnEvent =
  function(Me, event_name)
    if (Me.prev_event ~= 'nothing') then
      Me.is_on_empty_line = false
    end

    if (event_name == 'end_list') then
      Me.Indent:Dec()
    end

    local IndentFunc = EventsToFunc[Me.prev_event][event_name]
    IndentFunc(Me)

    if (event_name == 'start_list') then
      Me.Indent:Inc()
    end

    Me.prev_event = event_name
  end

-- Export:
return OnEvent

--[[
  2024 # # # # #
  2026-05-23
]]
