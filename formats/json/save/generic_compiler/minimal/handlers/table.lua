local is_arrayable = request('!.mechs.array.is_arrayable')
local to_array = request('!.mechs.array.from_table')

return
  function(self, data)
    if is_arrayable(data) then
      to_array(data)
      return self.handlers.wrap_array(self, data)
    else
      return self.handlers.wrap_object(self, data)
    end
  end
