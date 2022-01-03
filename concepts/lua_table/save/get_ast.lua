local RestorableTypes =
  {
    ['boolean'] = true,
    ['number'] = true,
    ['string'] = true,
    ['table'] = true,
  }

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
        for key, value in self.table_iterator(data) do
          if (
            self.OnlyRestorableItems and
              (
                not RestorableTypes[type(key)] or
                not RestorableTypes[type(value)]
              )
            )
          then
            goto next
          end
          local key_slot = self:get_ast(key)
          local value_slot = self:get_ast(value)
          result[#result + 1] =
            {
              key = key_slot,
              value = value_slot,
            }
        ::next::
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
