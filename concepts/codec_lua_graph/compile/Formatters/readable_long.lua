-- Notify handler for readable-long indentation

--[[
  Author: Martin Eden
  Last mod.: 2026-08-15
]]

local Indent = request('!.concepts.Indent')

Indent = Indent.create()

local emit_indent =
  function(Output)
    Output:Write('\n')

    local indent_str = Indent:ToString()

    if (indent_str == '') then return end

    Output:Write(indent_str)
  end

local prev_event_name = 'nothing'

local notify =
  function(next_event_name, Output)
    if (next_event_name == 'start_table') then
      Indent:Inc()
    elseif (next_event_name == 'end_table') then
      Indent:Dec()
    end

    if
      (
        (prev_event_name == 'start_table') and
        (next_event_name ~= 'end_table')
      ) or
      (prev_event_name == 'items_delimiter') or
      (
        (prev_event_name ~= 'start_table') and
        (next_event_name == 'end_table')
      )
    then
      emit_indent(Output)
    end

    prev_event_name = next_event_name
  end

-- Export:
return notify

--[[
  2026-06-19
  2026-08-15
]]
