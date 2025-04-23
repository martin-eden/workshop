-- Linear 1-d generator

-- Last mod.: 2025-04-23

--[[
  Generate linear gradient between two points

  If no endline pixels are set, we'll set them to random colors.
]]
local Run =
  function(self)
    self:Init()

    if (self.LineLength <= 2) then
      return
    end

    local Left = 1
    local Right = self.LineLength

    for X = Left + 1, Right - 1 do
      self:CreatePixel(X, Left, Right)
    end
  end

-- Exports:
return Run

--[[
  2025-04-05
  2025-04-15
  2025-04-23
]]
