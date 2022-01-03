return
  function(self, value)
    local Length = self:GetLength()
    self.FinishPoint:SetCoord(value)
    self.StartPoint:SetCoord(value - Length + 1)
  end
