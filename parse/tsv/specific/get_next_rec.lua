local trim_linefeed = request('^.^.^.string.trim_linefeed')

return
  function(self)
    local result
    local line = self.lines_iterator:get_next_line()
    if line then
      line = trim_linefeed(line)
      local pattern = '(.-)' .. '%' .. self.field_sep_char
      line = line .. self.field_sep_char
      result = {}
      for term in line:gmatch(pattern) do
        result[#result + 1] = term
      end
    end
    return result
  end
