return
  function(self, data)
    local result = {}
    result[#result + 1] = '{'
    local is_first = true
    for key, value in self.table_iterator(data) do
      if not is_first then
        result[#result + 1] = ','
      else
        is_first = false
      end
      result[#result + 1] = self:get_struc(key)
      result[#result + 1] = ':'
      result[#result + 1] = self:get_struc(value)
    end
    result[#result + 1] = '}'
    return result
  end
