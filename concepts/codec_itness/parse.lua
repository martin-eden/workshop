-- Read strings tree from input stream

--[[
  Author: Martin Eden
  Last mod.: 2026-09-24
]]

local Syntax = request('common.Syntax')

local read_token
do
  local quote_open_char = Syntax.quote_open_char
  local quote_close_char = Syntax.quote_close_char
  local space_char = Syntax.delimiters_space_char
  local newline_char = Syntax.delimiters_newline_char
  read_token =
    function(Input)
      local token = ''
      local in_quotes = false

      while true do
        local char = Input:Read(1)

        if (char == '') then
          return token
        end

        if in_quotes then
          if (char == quote_close_char) then
            in_quotes = false
          else
            token = token .. char
          end
        else
          if (char == space_char) or (char == newline_char) then
            if (token ~= '') then
              return token
            end
          elseif (char == quote_open_char) then
            in_quotes = true
          else
            token = token .. char
          end
        end
      end
    end
end

local parse
do
  local group_open_char = Syntax.group_open_char
  local group_close_char = Syntax.group_close_char

  local add_to_list = request('!.concepts.list.add_item')
  parse =
    function(Input)
      while true do
        local token = read_token(Input)

        if (token == '') then
          return
        end

        if (token == group_open_char) then
          local Result = { }
          while true do
            local Node = parse(Input)
            if not Node then break end
            add_to_list(Result, Node)
          end
          return Result
        elseif (token == group_close_char) then
          return
        else
          return token
        end
      end
    end
end

-- Export:
return parse

--[[
  2024 # # # #
  2026 # # # #
]]
