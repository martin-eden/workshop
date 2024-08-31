-- Return length of text without indent
return
  function(self)
    return utf8.len(self.text) or #self.text
  end
