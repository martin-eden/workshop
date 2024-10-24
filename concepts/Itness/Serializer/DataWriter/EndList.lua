-- Emit closing sequence character
return
  function(self)
    self.Output:Write(self.SyntaxChars.ListClosing)
  end
