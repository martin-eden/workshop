-- Read strings tree from input stream

--[[
  Author: Martin Eden
  Last mod.: 2026-05-27
]]

--[[
  Contract

  Function never fails.
]]

-- Imports:
local add_to_list = request('!.concepts.list.add_item')

local add_item =
  function(List, Item)
    if not is_nil(Item) then
      add_to_list(List, Item)
    end
  end

local parse_root =
  function(Input, Syntax)
    -- Syntels shortcuts:
    local group_open_char = Syntax.group_open_char
    local group_close_char = Syntax.group_close_char
    local quote_open_char = Syntax.quote_open_char
    local quote_close_char = Syntax.quote_close_char
    local space_char = Syntax.delimiters_space_char
    local newline_char = Syntax.delimiters_newline_char

    local parse
    parse =
      function()
        local Result = { }
        local term = nil
        local in_quotes = false

        while true do
          local char = Input:Read(1)

          if (char == '') then break end

          local action = 'add_char'

          if not in_quotes then
            if ((char == space_char) or (char == newline_char)) then
              action = 'end_term'
            elseif (char == quote_open_char) then
              action = 'start_quote'
            elseif (char == group_open_char) then
              action = 'start_group'
            elseif (char == group_close_char) then
              action = 'end_group'
            end
          elseif in_quotes then
            if (char == quote_close_char) then
              action = 'end_quote'
            end
          end

          if (action == 'add_char') then
            term = term or ''
            term = term .. char
          elseif (action == 'end_term') then
            add_item(Result, term)
            term = nil
          elseif (action == 'start_quote') then
            term = term or ''
            in_quotes = true
          elseif (action == 'end_quote') then
            in_quotes = false
          elseif (action == 'start_group') then
            add_item(Result, term)
            term = nil
            add_item(Result, parse())
          elseif (action == 'end_group') then
            add_item(Result, term)

            return Result
          end
        end

        add_item(Result, term)

        return Result
      end

    return parse()
  end

-- Export:
return parse_root

--[[
  2024 # # # #
  2026-05-23
  2026-05-26
]]
