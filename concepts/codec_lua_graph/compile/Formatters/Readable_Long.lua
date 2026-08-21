-- Indenter for "readable long" style

--[[
  Author: Martin Eden
  Last mod.: 2026-08-22
]]

local Indent
local prev_event_name

local empty = ''

local process_event
do
  local emit_indent
  do
    local newline
    do
      local AsciiChars = request('!.concepts.Ascii.Chars')
      newline = AsciiChars.newline
    end

    emit_indent =
      function(Output)
        Output:Write(newline)

        local indent_str = Indent:ToString()

        if (indent_str == empty) then return end

        Output:Write(indent_str)
      end
  end

  local event_start_table
  local event_end_table
  local event_start_item
  local event_end_item
  do
    local NotificationEvents = request('^.NotificationEvents')
    event_start_table = NotificationEvents.start_table
    event_end_table = NotificationEvents.end_table
    event_start_item = NotificationEvents.start_item
    event_end_item = NotificationEvents.end_item
  end

  process_event =
    function(next_event_name, Output)
      if (next_event_name == event_start_table) then
        Indent:Inc()
      elseif (next_event_name == event_end_table) then
        Indent:Dec()
      end

      if
        (
          (prev_event_name == event_start_table) and
          (next_event_name ~= event_end_table)
        ) or
        (prev_event_name == event_end_item) or
        (
          (prev_event_name ~= event_start_table) and
          (next_event_name == event_end_table)
        )
      then
        emit_indent(Output)
      end

      prev_event_name = next_event_name
    end
end

local create
do
  local IndentClass = request('!.concepts.Indent')
  create =
    function()
      Indent = IndentClass.create()
      prev_event_name = empty

      return process_event
    end
end

-- Export:
return
  {
    create = create,
  }

--[[
  2026 # #
  2026-08-22
]]
