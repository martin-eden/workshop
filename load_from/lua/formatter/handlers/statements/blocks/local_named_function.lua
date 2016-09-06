return
  function(self, node)
    self.printer:emit('local ')
    self.handlers.named_function(self, node)
  end
