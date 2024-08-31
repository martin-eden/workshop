-- Return length of indented text
return
  function(self)
    if self:is_empty() then
      return 0
    end

    return utf8.len(self.indent) + self:get_text_length()
  end
