-- Read strings tree from input stream

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local syntax = request('syntax')

local read_token
do
  local quote_open_char = syntax.quote_open_char
  local quote_close_char = syntax.quote_close_char
  local space_char = syntax.delimiters_space_char
  local newline_char = syntax.delimiters_newline_char
  local out_str_stream = request('!.concepts.streams.output.string')
  read_token =
    function(input)
      local str_stream = out_str_stream.create()
      local in_quotes = false

      while true do
        local char = input:read(1)

        if (char == '') then
          return str_stream:get_string()
        end

        if in_quotes then
          if (char == quote_close_char) then
            in_quotes = false
          else
            str_stream:write(char)
          end
        else
          if (char == space_char) or (char == newline_char) then
            local token = str_stream:get_string()
            if (token ~= '') then
              return token
            end
          elseif (char == quote_open_char) then
            in_quotes = true
          else
            str_stream:write(char)
          end
        end
      end
    end
end

local parse
do
  local group_open_char = syntax.group_open_char
  local group_close_char = syntax.group_close_char

  local add_to_list = request('!.concepts.list.add_item')
  parse =
    function(input)
      while true do
        local token = read_token(input)

        if (token == '') then
          return
        end

        if (token == group_open_char) then
          local result = { }
          while true do
            local node = parse(input)
            if not node then break end
            add_to_list(result, node)
          end
          return result
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
  2026-10-14
]]
