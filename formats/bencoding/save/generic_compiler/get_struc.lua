local is_array = request('!.mechs.array.is_array')

return
  function(self, data)
    local data_type
    if is_integer(data) then
      data_type = 'integer'
    elseif is_table(data) then
      if is_array(data) then
        data_type = 'list'
      else
        data_type = 'dictionary'
      end
    elseif is_string(data) then
      data_type = 'string'
    end
    local handler = self.handlers[data_type]
    return handler(self, data)
  end
