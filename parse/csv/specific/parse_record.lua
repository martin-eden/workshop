-- Comma-separated lines parser

--[[
  Implemented as state machine with function records.
]]

local quote_char
local field_sep_char
local record_sep_char

local eot = ''
local term
local parse_result

local st_waiting_to_begin
local st_reading_unquoted
local st_reading_in_quotes
local st_checking_double_quotes
local st_waiting_delimiter
local st_finished
local st_broken

local add_term =
  function()
    parse_result[#parse_result + 1] = term
    term = ''
    -- print(('[%d] = %q'):format(#result, parse_result[#parse_result]))
  end

st_waiting_to_begin =
  function(cur_char)
    local result
    if (cur_char == record_sep_char) or (cur_char == eot) then
      add_term()
      result = st_finished
    elseif (cur_char == field_sep_char) then
      add_term() --term is empty string in this case
    elseif (cur_char == quote_char) then
      result = st_reading_in_quotes
    else
      term = term .. cur_char
      result = st_reading_unquoted
    end
    return result
  end

st_reading_unquoted =
  function(cur_char)
    local result
    if (cur_char == record_sep_char) or (cur_char == eot) then
      add_term()
      result = st_finished
    elseif (cur_char == field_sep_char) then
      add_term()
      result = st_waiting_to_begin
    else
      term = term .. cur_char
    end
    return result
  end

st_reading_in_quotes =
  function(cur_char)
    local result
    if (cur_char == quote_char) then
      result = st_checking_double_quotes
    elseif (cur_char == eot) then
      result = st_broken
    else
      term = term .. cur_char
    end
    return result
  end

st_checking_double_quotes =
  function(cur_char)
    local result
    if (cur_char == quote_char) then
      term = term .. cur_char
      result = st_reading_in_quotes
    elseif (cur_char == record_sep_char) or (cur_char == eot) then
      add_term()
      result = st_finished
    elseif (cur_char == field_sep_char) then
      add_term()
      result = st_waiting_to_begin
    else
      add_term()
      result = st_waiting_delimiter
    end
    return result
  end

st_waiting_delimiter =
  function(cur_char)
    local result
    if (cur_char == record_sep_char) or (cur_char == eot) then
      result = st_finished
    elseif (cur_char == field_sep_char) then
      result = st_waiting_to_begin
    else
      result = st_broken
    end
    return result
  end

st_finished =
  function(cur_char)
    error()
  end

st_broken = --unclosed quote
  function(cur_char)
    error()
  end

return
  function(parent, s)
    quote_char = parent.quote_char
    field_sep_char = parent.field_sep_char
    record_sep_char = parent.record_sep_char
    parse_result = {}
    term = ''
    local handle = st_waiting_to_begin
    local cur_position = 1
    while true do
      local cur_char = s:sub(cur_position, cur_position)
      handle = handle(cur_char) or handle
      if (handle == st_finished) or (handle == st_broken) then
        break
      end
      cur_position = cur_position + 1
    end
    local has_errors = (handle == st_broken)
    return parse_result, cur_position, has_errors
  end
