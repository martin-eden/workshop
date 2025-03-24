-- Return length of text without indent
return
  function(self)
    return string.len(self.text) or #self.text
  end
