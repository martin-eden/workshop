return
  function(self)
    for i = #self.Stages, 1, -1 do
      if (not self.Stages[i].IsCompleted) then
        return self.Stages[i].Depth
      end
    end
    return 0
  end
