local parse_line = request('parse_line')

return
  function(self)
    local result
    local line, prev_line
    local has_problems, need_next_line
    ::read::
    line = self.lines_iterator:get_next_line()
    if line then
      if prev_line then
        line = prev_line .. line
        prev_line = nil
      end
      result, has_problems, need_next_line = parse_line(self, line)
      if need_next_line then
        prev_line = line
        goto read
      end
      if has_problems then
        result = nil
      end
    end
    return result
  end
