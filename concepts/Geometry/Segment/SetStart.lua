return
  function(self, value)
    self.StartPoint:SetCoord(value)
    if (self:GetLength() < 0) then
      self.FinishPoint:SetCoord(self.StartPoint:GetCoord() - 1)
    end
  end
