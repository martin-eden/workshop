-- Setup item getter

-- Last mod.: 2025-03-29

local LineComment = request('^.^.Settings.Interface').LineCommentChar

return
  function(self)
    self.CharacterClassifier.LineCommentStart = { LineComment }
    self.CharacterClassifier:Init()
  end

--[[
  2025-03-28
]]
