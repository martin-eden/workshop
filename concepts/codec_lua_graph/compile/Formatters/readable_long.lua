-- Tree formatter for long or complex data

--[[
  Author: Martin Eden
  Last mod.: 2026-06-20
]]

-- Imports:
local Indent = request('!.concepts.Indent')
local patch_table = request('!.table.patch')

Indent = Indent.create()

local emit_indent =
  function(Output)
    Output:Write('\n')

    if (Indent.RangePoint.value == 0) then return end

    Output:Write(Indent:ToString())
  end

local prev_event_name = 'nothing'

local on_notify =
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

local install =
  function(Config)
    patch_table(
      Config,
      {
        use_compact_indices = true,
        use_compact_sequences = false,
        omit_tail_delimiter = false,

        empty_table_str = '{ }',
        opening_table_str = '{',
        closing_table_str = '}',
        delimiter_str = ',',
        equal_str = ' = ',

        notify = on_notify,
      }
    )
  end

-- Export:
return install

--[[
  2026-06-19
]]
