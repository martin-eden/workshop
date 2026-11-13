-- Data serialization functions

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

--[[
  This class does not care about items delimiting

  It does care about items serialization.
]]

--[[
  Storage format

    1 [s] regexp to capture any of syntax characters
    2 [t] output stream
]]

--[[
  Implementation

    State machine.

    State is "Quoted" or "Unquoted".

    "Quoted" is when we emitted opening quote "[". In this state we are
    worrying only about encountering closing quote "]" in data. And
    adding closing quote when data ends.

    "Unquoted" is default state. We're writing characters as-is
    until first syntax character.

    (Except for end-of-quote character. end-of-quote character "]" does
    not require switching to "quoted" state.)
]]

local syntax = request('^.syntax')

local start_list
do
  local group_open_char = syntax.group_open_char
  start_list =
    function(me)
      me[2]:write(group_open_char)
    end
end

local end_list
do
  local group_close_char = syntax.group_close_char
  end_list =
    function(me)
      me[2]:write(group_close_char)
    end
end

local write_leaf
do
  local quote_open_char = syntax.quote_open_char
  local quote_close_char = syntax.quote_close_char
  local str_gsub = string.gsub
  write_leaf =
    function(me, str)
      local in_quotes = false

      local encode_str
      do
        local encode_char =
          function(char)
            local result = char
            if not in_quotes then
              if (char ~= quote_close_char) then
                result = quote_open_char .. char
                in_quotes = true
              end
            else
              if (char == quote_close_char) then
                result = quote_close_char .. char
                in_quotes = false
              end
            end
            return result
          end
        encode_str =
          function(str)
            if (str == '') then
              return quote_open_char .. quote_close_char
            end
            local result = str_gsub(str, me[1], encode_char)
            if in_quotes then
              result = result .. quote_close_char
              in_quotes = false
            end
            return result
          end
      end

      me[2]:write(encode_str(str))
    end
end

local interface
local create
do
  local syntax_chars_regexp
  do
    local get_values = request('!.table.get_values')
    local list_to_str = request('!.concepts.list.to_string')
    local quote_regexp = request('!.lua.regexp.quote')
    syntax_chars_regexp =
      '[' .. quote_regexp(list_to_str(get_values(syntax))) .. ']'
  end
  local attach_methods = request('!.table.attach_methods')
  create =
    function(output)
      local me = { syntax_chars_regexp, output }
      attach_methods(me, interface)
      return me
    end
end

interface =
  {
    create = create,
    start_list = start_list,
    end_list = end_list,
    write_leaf = write_leaf,
  }

-- Export:
return interface

--[[
  2024 # #
  2026 #
  2026-11-13
]]
