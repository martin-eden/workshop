-- Comma-separated lines parser

local quote_char = '"'
local space_char = ' '
local field_sep_char = ','
local record_sep_char = '\n'
local eot = ''

local term
local result

local term_chars = {}

local add_char =
  function(char)
    term = term .. char
  end

local add_term =
  function()
    result[#result + 1] = term
    term = ''
    --[[
      I've tested variant with storing chars in array and
      table.concat-ing them. Result is almost same (worse
      on about 1%). So let's "term = term .. char" remain
      to keep code simple.
    ]]
    -- print(('[%d] = %q'):format(#result, result[#result]))
  end

local states
states =
  {
    waiting_to_begin =
      function(cur_char)
        local next_state
        if (cur_char == record_sep_char) or (cur_char == eot) then
          add_term()
          next_state = states.finished
        elseif (cur_char == field_sep_char) then
          add_term() --term is empty string in this case
        elseif (cur_char == quote_char) then
          next_state = states.reading_in_quotes
        else
          add_char(cur_char)
          next_state = states.reading_unquoted
        end
        return next_state
      end,
    reading_unquoted =
      function(cur_char)
        local next_state
        if (cur_char == record_sep_char) or (cur_char == eot) then
          add_term()
          next_state = states.finished
        elseif (cur_char == field_sep_char) then
          add_term()
          next_state = states.waiting_to_begin
        else
          add_char(cur_char)
        end
        return next_state
      end,
    reading_in_quotes =
      function(cur_char)
        local next_state
        if (cur_char == quote_char) then
          next_state = states.checking_double_quotes
        elseif (cur_char == eot) then
          next_state = states.broken
        else
          add_char(cur_char)
        end
        return next_state
      end,
    checking_double_quotes =
      function(cur_char)
        local next_state
        if (cur_char == quote_char) then
          add_char(quote_char)
          next_state = states.reading_in_quotes
        elseif (cur_char == record_sep_char) or (cur_char == eot) then
          add_term()
          next_state = states.finished
        elseif (cur_char == field_sep_char) then
          add_term()
          next_state = states.waiting_to_begin
        else
          add_term()
          next_state = states.waiting_delimiter
        end
        return next_state
      end,
    waiting_delimiter =
      function(cur_char)
        local next_state
        if (cur_char == record_sep_char) or (cur_char == eot) then
          next_state = states.finished
        elseif (cur_char == field_sep_char) then
          next_state = states.waiting_to_begin
        else
          next_state = states.broken
        end
        return next_state
      end,
    finished =
      function(cur_char)
        error()
      end,
    broken = --unclosed quote
      function(cur_char)
        error()
      end,
  }

local debug_state_names =
  {
    [states.waiting_to_begin] = 'waiting_to_begin',
    [states.reading_unquoted] = 'reading_unquoted',
    [states.reading_in_quotes] = 'reading_in_quotes',
    [states.checking_double_quotes] = 'checking_double_quotes',
    [states.waiting_delimiter] = 'waiting_delimiter',
    [states.finished] = 'finished',
    [states.broken] = 'broken',
  }

--[[
local quote_string = request('^.^.compile.lua.quote_string')
local debug_print_state =
  function(cur_state, cur_char)
    print(('%s\t%s'):format(debug_state_names[cur_state], quote_string(cur_char)))
  end
]]

return
  function(s)
    result = {}
    term = ''
    local cur_position = 1
    local state = states.waiting_to_begin
    while true do
      local cur_char = s:sub(cur_position, cur_position)
      -- debug_print_state(state, cur_char)
      state = state(cur_char) or state
      if (state == states.finished) or (state == states.broken) then
        break
      end
      cur_position = cur_position + 1
    end
    local has_errors = (state == states.broken)
    return result, cur_position, has_errors
  end
