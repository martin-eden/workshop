--[[
  Return parameters are for assert() usage.
]]

return
  function(self)
    local data = self.data
    local field_sep = self.field_separator
    local record_sep = self.record_separator
    local err_msg
    for i = 1, #data do
      for j = 1, #data[i] do
        local field = data[i][j]
        if field:find(field_sep, 1, true) then
          err_msg =
            ('Encountered field delimiter char %q in field "%s" (%d, %d)'):
            format(field_sep, field, i, j)
        end
        if field:find(record_sep, 1, true) then
          err_msg =
            ('Encountered record delimiter char %q in field %q (%d, %d)'):
            format(record_sep, field, i, j)
        end
        if err_msg then
          return nil, err_msg
        end
      end
    end
    return true
  end
