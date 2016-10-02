return
  function(self)
    local data = self.data
    assert_table(data)
    local delimiter = self.delimiter
    assert_string(delimiter)
    delimiter = '%' .. delimiter
    for i = 1, #data do
      for j = 1, #data[i] do
        local field = data[i][j]
        field = field or ''
        field = tostring(field)
        field = field:gsub(delimiter, '')
        field = field:gsub('\n', '')
        data[i][j] = field
      end
    end
  end
