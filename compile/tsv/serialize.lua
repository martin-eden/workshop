local check_fix = request('^.^.handy_mechs.oo_patterns.check_fix')

return
  function(self)
    check_fix(self)
    local result = {}
    for i = 1, #self.data do
      result[i] = table.concat(self.data[i], self.field_separator)
    end
    result = table.concat(result, self.record_separator)
    result = result .. self.record_separator
    return result
  end
