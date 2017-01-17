return
  function(self)
    local result = 0
    local indent_chunk_len = utf8.len(self.indent_chunk)
    for i = 1, #self.text.lines do
      local line_len =
        indent_chunk_len * self.line_indents[i] + utf8.len(self.text.lines[i])
      if (line_len > result) then
        result = line_len
      end
    end
    return result
  end
