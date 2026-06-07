-- Delimiters writer. Event handler

--[[
  Author: Martin Eden
  Last mod.: 2026-06-07
]]

-- Write string. Update empty line state
local Emit =
  function(Me, str)
    if (str == '') then return end

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

-- Write newline and indentation
local EmitIndent =
  function(Me)
    EmitNewline(Me)
    Emit(Me, Me.Indent:ToString())
  end

-- Delimiting functions:
local F_Empty = function(Me) end
local F_Indent = function(Me) EmitIndent(Me) end
local F_Space = function(Me) Emit(Me, Me.space_char) end

--[[
  Decision matrix

  Return delimiting function given previous and current events.
]]
local EventsToFunc =
  {
    ['nothing'] =
      {
        ['nothing'] = F_Empty,
        ['write_string'] = F_Empty,
        ['start_list'] = F_Empty,
        ['end_list'] = F_Empty,
      },
    ['write_string'] =
      {
        ['nothing'] = F_Empty,
        ['write_string'] = F_Space,
        ['start_list'] = F_Indent,
        ['end_list'] = F_Space,
      },
    ['start_list'] =
      {
        ['nothing'] = F_Empty,
        ['write_string'] = F_Space,
        ['start_list'] = F_Indent,
        ['end_list'] = F_Empty,
      },
    ['end_list'] =
      {
        ['nothing'] = F_Indent,
        ['write_string'] = F_Indent,
        ['start_list'] = F_Indent,
        ['end_list'] = F_Indent,
      },
  }

--[[
  Write delimiters between items

  Should be called before writing non-delimiting element.

  Delimiter depends of previous and current item types.

  Input

    Me [t]
    cur_event [s] -- event name:
      ( nothing start_list write_string end_list )
]]
local OnEvent =
  function(Me, cur_event)
    if (Me.prev_event ~= 'nothing') then
      Me.is_on_empty_line = false
    end

    if (cur_event == 'end_list') then Me.Indent:Dec() end

    local PaddingFunc = EventsToFunc[Me.prev_event][cur_event]
    PaddingFunc(Me)

    if (cur_event == 'start_list') then Me.Indent:Inc() end

    Me.prev_event = cur_event
  end

-- Export:
return OnEvent

--[[
  2024 # # # # #
  2026-05-23
  2026-06-07
]]
