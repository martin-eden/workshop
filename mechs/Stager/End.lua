return
  function(self)
    for i = #self.Stages, 1, -1 do
      if (self.Stages[i].IsCompleted) then
        table.remove(self.Stages)
      else
        self.Stages[i].IsCompleted = true
        break
      end
    end
  end
