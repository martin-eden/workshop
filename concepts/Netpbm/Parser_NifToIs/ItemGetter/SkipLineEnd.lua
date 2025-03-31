-- Move read pointer to next line

-- Last mod.: 2025-03-28

-- Used to skip line comment contents

return
  function(self)
    local CharWizard = self.CharacterClassifier

    while self:GetNextCharacter() do
      if CharWizard:IsLineCommentEnd(self.NextCharacter) then
        break
      end
    end
  end

--[[
  2025-03-28
]]
