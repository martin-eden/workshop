return
  function(self, value)
    self.FinishPoint:SetCoord(value)
    if (self:GetLength() < 0) then
      self.StartPoint:SetCoord(self.FinishPoint:GetCoord() + 1)
    end
  end
