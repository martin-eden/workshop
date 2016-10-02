local check_fix = request('^.^.handy_mechs.oo_patterns.check_fix')

return
  function(self)
    check_fix(self)
    local result = {}
    for i = 1, #self.data do
      result[i] = table.concat(self.data[i], self.delimiter)
    end
    result = table.concat(result, '\n')
    result = result .. '\n'
    return result
  end
