-- Get next item

-- Last mod.: 2025-03-28

--[[
  Get next item

  Skips item delimiters and line comments.

    > P3
    > 1920 1080 # Width Height
    > 255

  Items are "P3", "1920", "1080", "255"
]]
local GetNextItem =
  function(self)
    local CharWizard = self.CharacterClassifier

    -- Advance read pointer till essential character
    while self:GetNextCharacter() do
      local Char = self.NextCharacter

      if CharWizard:IsDelimiter(Char) then
        if CharWizard:IsLineCommentStart(Char) then
          self:SkipLineEnd()
        end
      else
        break
      end
    end

    -- Add characters to result item
    local Result = self.NextCharacter

    while self:GetNextCharacter() do
      local Char = self.NextCharacter

      if CharWizard:IsDelimiter(Char) then
        if CharWizard:IsLineCommentStart(Char) then
          self:SkipLineEnd()
        end
        break
      end

      Result = Result .. Char
    end

    return Result
  end

-- Exports:
return GetNextItem

--[[
  2024-11-02
  2025-03-27
  2025-03-28
]]
