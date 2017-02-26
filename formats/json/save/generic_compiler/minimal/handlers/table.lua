local is_array = request('!.mechs.array.is_array')

return
  function(self, data)
    if is_array(data) then
      return self.handlers.wrap_array(self, data)
    else
      return self.handlers.wrap_object(self, data)
    end
  end
