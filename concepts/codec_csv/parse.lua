-- Parse CSV input stream

--[[
  Author: Martin Eden
  Last mod.: 2026-07-14
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')
local Actions = request('parse.Actions')
local get_action_and_state = request('parse.get_action_and_state')

local action_add_char = Actions.add_char
local action_add_field = Actions.add_field
local action_add_record = Actions.add_record

local parse =
  function(InputStream)
    local Records = { }

    local Record = { }
    local field_str = ''

    local add_field = false
    local add_record = false
    local do_exit = false

    local action, state

    while true do
      local char = InputStream:Read(1)

      if (char == '') then
        add_field = true
        add_record = true
        do_exit = true
      else
        action, state = get_action_and_state(char, state)

        if (action == action_add_char) then
          field_str = field_str .. char
        elseif (action == action_add_field) then
          add_field = true
        elseif (action == action_add_record) then
          add_field = true
          add_record = true
        end
      end

      if add_field then
        add_to_list(Record, field_str)
        field_str = ''

        add_field = false
      end

      if add_record then
        add_to_list(Records, Record)
        Record = { }

        add_record = false
      end

      if do_exit then break end
    end

    return Records
  end

-- Export:
return parse

--[[
  2026-07-14
]]
