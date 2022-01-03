return
  function(self, value)
    local Length = self:GetLength()
    self.StartPoint:SetCoord(value)
    self.FinishPoint:SetCoord(value + Length - 1)
  end
