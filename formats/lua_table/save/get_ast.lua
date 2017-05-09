local name_giver = request('!.mechs.name_giver')

return
  function(self, data)
    local result
    local data_type = type(data)
    if (data_type == 'table') then
      if self.value_names[data] then
        result =
          {
            type = 'name',
            value = self.value_names[data],
          }
      else
        result = {}
        result.type = 'table'
        self.value_names[data] = name_giver:give_name(data)
        for key, value in self.table_iterator(data) do
          if
            not self.ignored_values[key] and
            not self.ignored_values[value]
          then
            local key_slot = self:get_ast(key)
            local value_slot = self:get_ast(value)
            result[#result + 1] =
              {
                key = key_slot,
                value = value_slot,
              }
          end
        end
      end
    else
      result =
        {
          type = data_type,
          value = data,
        }
    end
    return result
  end
