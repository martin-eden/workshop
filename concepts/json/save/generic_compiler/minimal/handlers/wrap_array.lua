return
  function(self, data)
    local result = {}
    result[#result + 1] = '['
    for i = 1, #data do
      if (i > 1) then
        result[#result + 1] = ','
      end
      result[#result + 1] = self:get_struc(data[i])
    end
    result[#result + 1] = ']'
    return result
  end
