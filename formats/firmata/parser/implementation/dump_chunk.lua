return
  function(self, chunk)
    local result = {}
    for i = 1, #chunk do
      local char_code = chunk:byte(i, i)
      table.insert(result, ('%02X'):format(char_code))
    end
    result = table.concat(result, ' ')
    return result
  end
