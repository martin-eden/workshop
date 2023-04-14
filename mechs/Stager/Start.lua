return
  function(self, StageName)
    local Rec =
      {
        Depth = self:GetLastDepth() + 1,
        Name = StageName,
        IsCompleted = false,
      }
    table.insert(self.Stages, Rec)
  end
