-- Decision-maker function for current input character and state

--[[
  Author: Martin Eden
  Last mod.: 2026-07-14
]]

-- Imports:
local Syntax = request('^.common.Syntax')

local records_separator = Syntax.records_separator
local fields_separator = Syntax.fields_separator
local quote_char = Syntax.quote_char

local charclass_fields_separator = 'fields_separator'
local charclass_records_separator = 'records_separator'
local charclass_quote_char = 'quote_char'
local charclass_ordinary_char = 'ordinary_char'

local state_initial = 'initial'
local state_reading_unquoted = 'reading_unquoted'
local state_reading_quoted = 'reading_quoted'
local state_hanging_quote = 'hanging_quote'

local Actions = request('Actions')
local action_add_char = Actions.add_char
local action_add_field = Actions.add_field
local action_add_record = Actions.add_record
local action_do_nothing = Actions.do_nothing

--[[
  Decisions matrix

  For given state and character class returns new state and action.
]]
local DecisionsMatrix =
  {
    [state_initial] =
      {
        [charclass_ordinary_char] =
          { action_add_char, state_reading_unquoted },
        [charclass_fields_separator] =
          { action_add_field },
        [charclass_records_separator] =
          { action_add_record },
        [charclass_quote_char] =
          { action_do_nothing, state_reading_quoted },
      },
    [state_reading_unquoted] =
      {
        [charclass_ordinary_char] =
          { action_add_char },
        [charclass_fields_separator] =
          { action_add_field, state_initial },
        [charclass_records_separator] =
          { action_add_record, state_initial },
        [charclass_quote_char] =
          { action_add_char },
      },
    [state_reading_quoted] =
      {
        [charclass_ordinary_char] =
          { action_add_char },
        [charclass_fields_separator] =
          { action_add_char },
        [charclass_records_separator] =
          { action_add_char },
        [charclass_quote_char] =
          { action_do_nothing, state_hanging_quote },
      },
    [state_hanging_quote] =
      {
        [charclass_ordinary_char] =
          { action_add_char, state_initial },
        [charclass_fields_separator] =
          { action_add_field, state_initial },
        [charclass_records_separator] =
          { action_add_record, state_initial },
        [charclass_quote_char] =
          { action_add_char, state_reading_quoted },
      },
  }

local get_action_and_state =
  function(char, cur_state)
    cur_state = cur_state or state_initial

    local char_class

    if (char == fields_separator) then
      char_class = charclass_fields_separator
    elseif (char == records_separator) then
      char_class = charclass_records_separator
    elseif (char == quote_char) then
      char_class = charclass_quote_char
    else
      char_class = charclass_ordinary_char
    end

    local Decision = DecisionsMatrix[cur_state][char_class]

    local action = Decision[1]
    local new_state = Decision[2] or cur_state

    return action, new_state
  end

-- Export:
return get_action_and_state

--[[
  2026-07-14
]]
