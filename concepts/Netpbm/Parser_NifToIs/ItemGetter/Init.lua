-- Setup item getter

-- Last mod.: 2025-03-28

local LineComment = request('^.^.Constants.Interface').LineCommentChar

return
  function(self)
    self.CharacterClassifier.LineCommentStart = { LineComment }
    self.CharacterClassifier:Init()
  end

--[[
  2025-03-28
]]
