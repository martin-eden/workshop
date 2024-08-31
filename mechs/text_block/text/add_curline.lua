return
  function(self, s)
    if (self.num_line_feeds > 0) and (s ~= '') then
      --[[
        We're going to add some text to currently empty line.
        So <line_with_text> will point to this text. Save previous
        text from this object.
      ]]
      self:store_textline()
    end
    self.line_with_text:add(s)
  end
