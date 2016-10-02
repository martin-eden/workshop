--[[
  Return parameters are for assert() usage.
]]

return
  function(self)
    local data = self.data
    assert_table(data)
    local delimiter = self.delimiter
    assert_string(delimiter)
    local err_msg
    for i = 1, #data do
      for j = 1, #data[i] do
        local field = data[i][j]
        if field:find(delimiter, 1, true) then
          err_msg =
            ('Encountered delimiter char %q in field "%s" (%d, %d)'):
            format(delimiter, field, i, j)
        end
        if field:find('\n', 1, true) then
          err_msg =
            ('Encountered linefeed char in field %q (%d, %d)'):
            format(field, i, j)
        end
        if err_msg then
          return nil, err_msg
        end
      end
    end
    return true
  end
