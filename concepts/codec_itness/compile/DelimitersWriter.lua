-- Data separation/indentation

--[[
  Author: Martin Eden
  Last mod.: 2026-07-05
]]

--[[
  We don't care about items encoding. It's [DataWriter]'s job.

  We do care about whitespaces and types of adjacent items.

  Delimiter depends from types of adjacent items.
  So central idea here is to create matrix ( prev_item cur_item )
  which will store what action to apply.
]]

--[[
  Storage format

    1 [s] space char
    2 [s] newline char
    3 [t] indent instance
    4 [s] previous event
    5 [b] is on empty line?
    6 [t] output stream
]]

-- Write string. Update "is on empty line" flag
local emit =
  function(Me, str)
    if (str == '') then return end
    Me[6]:Write(str)
    Me[5] = false
  end

-- Delimiting functions:

local F_Empty = function(Me) end

local F_Space = function(Me) emit(Me, Me[1]) end

local F_Indent =
  -- Write newline and indentation
  function(Me)
    -- Assure that next string will be written on new line
    if not Me[5] then
      emit(Me, Me[2])
      Me[5] = true
    end

    emit(Me, Me[3]:ToString())
  end

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

  Delimiter depends of previous and current item types.
]]
local handle_event =
  function(Me, cur_event)
    local Indent = Me[3]
    local prev_event = Me[4]
    local is_on_empty_line = Me[5]

    if (prev_event ~= 'nothing') then
      is_on_empty_line = false
    end

    if (cur_event == 'end_list') then Indent:Dec() end

    EventsToFunc[prev_event][cur_event](Me)

    if (cur_event == 'start_list') then Indent:Inc() end

    prev_event = cur_event

    Me[4] = prev_event
    Me[5] = is_on_empty_line
  end

local create
local Interface
do
  local IndentClass = request('!.concepts.Indent')
  local spaces_per_indent = 2
  local str_rep = string.rep
  local attach_methods = request('!.table.attach_methods')
  create =
    function(space_char, newline_char, OutputStream)
      local Indent = IndentClass.create()
      local indent_chunk = str_rep(space_char, spaces_per_indent)
      Indent:SetIndentChunk(indent_chunk)

      local Me =
        {
          [1] = space_char,
          [2] = newline_char,
          [3] = Indent,
          [4] = 'nothing',
          [5] = true,
          [6] = OutputStream,
        }

      attach_methods(Me, Interface)

      return Me
    end
end

Interface =
  {
    create = create,
    HandleEvent = handle_event,
  }

-- Export:
return Interface

--[[
  2024 # # # # #
  2025 #
  2026 # #
  2026-10-14
]]
