return
  function(self, data)
    return self.handlers[type(data)](self, data)
  end
