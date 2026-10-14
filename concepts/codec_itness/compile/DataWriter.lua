-- Data serialization functions

--[[
  Author: Martin Eden
  Last mod.: 2026-10-14
]]

--[[
  This class does not care about items delimiting.

  It does care about items serialization.
]]

--[[
  Storage format

    1 [s] group opening character
    2 [s] group closing character
    3 [s] quote opening character
    4 [s] quote closing character
    5 [t] map of all syntax characters
    6 [s] regexp to capture any of syntax characters
    7 [t] output stream
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

local start_list = function(Me) Me[7]:Write(Me[1]) end
local end_list = function(Me) Me[7]:Write(Me[2]) end

local write_leaf
do
  local str_gsub = string.gsub
  write_leaf =
    function(Me, str)
      local quote_open_char = Me[3]
      local quote_close_char = Me[4]
      local IsSyntaxChar_Map = Me[5]
      local syntax_chars_regexp = Me[6]

      -- State: is character inside quotes?
      local in_quotes = false

      -- Encode character
      local encode_char =
        function(char)
          if not IsSyntaxChar_Map[char] then return char end

          local Result = char

          if not in_quotes then
            if (char ~= quote_close_char) then
              Result = quote_open_char .. char
              in_quotes = true
            end
          else
            if (char == quote_close_char) then
              Result = quote_close_char .. char
              in_quotes = false
            end
          end

          return Result
        end

      -- Quote syntax characters in data
      local encoded_str = str_gsub(str, syntax_chars_regexp, encode_char)

      -- Close opened quote at end of string
      if in_quotes then
        encoded_str = encoded_str .. quote_close_char
        in_quotes = false
      end

      -- Special case: empty string. Serialize to "[]"
      if (str == '') then
        encoded_str = quote_open_char .. quote_close_char
      end

      Me[7]:Write(encoded_str)
    end
end

local create
local Interface

do
  local map_values = request('!.table.map_values')
  local list_to_str = request('!.concepts.list.to_string')
  local quote_regexp = request('!.lua.regexp.quote')
  local attach_methods = request('!.table.attach_methods')

  --[[
    Input format

      1 [t] list of syntax characters. Referenced in following nodes
      2 [i] index of group opening character
      3 [i] index of group closing character
      4 [i] index of quote opening character
      5 [i] index of quote closing character
      6 [t] output stream
  ]]

  create =
    function(
      SyntaxChars,
      group_open_idx,
      group_close_idx,
      quote_open_idx,
      quote_close_idx,
      OutputStream
    )
      local SyntaxChars_Map = map_values(SyntaxChars)

      local syntax_chars_regexp =
        '[' .. quote_regexp(list_to_str(SyntaxChars)) .. ']'

      local Me =
        {
          [1] = SyntaxChars[group_open_idx],
          [2] = SyntaxChars[group_close_idx],
          [3] = SyntaxChars[quote_open_idx],
          [4] = SyntaxChars[quote_close_idx],
          [5] = SyntaxChars_Map,
          [6] = syntax_chars_regexp,
          [7] = OutputStream,
        }

      attach_methods(Me, Interface)

      return Me
    end
end

Interface =
  {
    create = create,
    StartList = start_list,
    EndList = end_list,
    WriteLeaf = write_leaf,
  }

-- Export:
return Interface

--[[
  2024 # #
  2026-10-14
]]
