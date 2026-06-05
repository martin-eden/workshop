-- Get next item

--[[
  Author: Martin Eden
  Last mod.: 2026-06-05
]]

--[[
  Skips item delimiters and line comments.

  Example:

    For string with lines

      P3
      1920 1080 # Width Height
      255

    Successive calls will return 'P3', '1920', '1080', '255'.
]]

-- Imports:
local CharacterClassifier = request('get_next_item.CharacterClassifier')

local drop_line_end =
  function(Input)
    while true do
      local char = Input:Read(1)

      if (char == '') then break end

      if CharacterClassifier.is_newline(char) then break end
    end
  end

local get_next_item =
  function(Input)
    local char

    -- Advance read pointer till essential character
    while true do
      char = Input:Read(1)

      if (char == '') then break end

      if CharacterClassifier.is_delimiter(char) then
        if CharacterClassifier.is_comment(char) then
          drop_line_end(Input)
        end
      else
        break
      end
    end

    -- Add characters to result item
    local result = char

    while true do
      char = Input:Read(1)

      if (char == '') then break end

      if CharacterClassifier.is_delimiter(char) then
        if CharacterClassifier.is_comment(char) then
          drop_line_end(Input)
        end
        break
      end

      result = result .. char
    end

    return result
  end

-- Exports:
return get_next_item

--[[
  2024-11-02
  2025-03-27
  2025-03-28
  2026-05-31
]]
