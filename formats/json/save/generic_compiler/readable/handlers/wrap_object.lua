return
  function(self, data)
    local result = {}
    result[#result + 1] = '{\n'
    self:inc_indent()
    local indent_str = self:get_indent_str()
    local is_first = true
    for key, value in self.table_iterator(data) do
      if not is_first then
        result[#result + 1] = ',\n'
      else
        is_first = false
      end
      result[#result + 1] = indent_str
      result[#result + 1] = self:get_struc(key)
      result[#result + 1] = ': '
      result[#result + 1] = self:get_struc(value)
    end
    self:dec_indent()
    result[#result + 1] = '\n' .. self:get_indent_str() .. '}'
    return result
  end
