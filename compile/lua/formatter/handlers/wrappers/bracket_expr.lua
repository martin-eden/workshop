return
  function(self, node)
    self.printer:emit('[')
    self.handlers.expression(self, node)
    self.printer:emit(']')
  end
