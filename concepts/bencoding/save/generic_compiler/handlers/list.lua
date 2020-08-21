return
  function(self, data)
    local result = {}
    result[#result + 1] = 'l'
    for i = 1, #data do
      result[#result + 1] = self:get_struc(data[i])
    end
    result[#result + 1] = 'e'
    return result
  end
