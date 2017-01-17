return
  function(self, line_num)
    local result =
      self.indents_obj.indents[self.line_indents[line_num]] ..
      self.text.lines[line_num]
    return result
  end
