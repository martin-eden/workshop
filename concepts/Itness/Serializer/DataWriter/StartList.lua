-- Emit opening sequence character
return
  function(self)
    self.Output:Write(self.SyntaxChars.ListOpening)
  end
