return
  function(self, data)
    local result = {}
    result[#result + 1] = 'd'
    for key, value in self.table_iterator(data) do
      result[#result + 1] = self:get_struc(key)
      result[#result + 1] = self:get_struc(value)
    end
    result[#result + 1] = 'e'
    return result
  end
