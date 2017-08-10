local quote_regexp = request('!.funcs.lua.regexps.quote')

return
  function(self)
    local data = self.data
    local field_sep = quote_regexp(self.field_separator)
    local record_sep = quote_regexp(self.record_separator)
    for i = 1, #data do
      for j = 1, #data[i] do
        local field = data[i][j]
        field = field or ''
        field = tostring(field)
        field = field:gsub(field_sep, '')
        field = field:gsub(record_sep, '')
        data[i][j] = field
      end
    end
  end
