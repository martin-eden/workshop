return
  function(self, data)
    local result = {}
    result[#result + 1] = '[\n'
    self:inc_indent()
    local indent_str = self:get_indent_str()
    for i = 1, #data do
      if (i > 1) then
        result[#result + 1] = ',\n'
      end
      result[#result + 1] = indent_str
      result[#result + 1] = self:get_struc(data[i])
    end
    self:dec_indent()
    result[#result + 1] = '\n' .. self:get_indent_str() .. ']'
    return result
  end
