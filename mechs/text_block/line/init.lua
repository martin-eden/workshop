-- Set indent string and empty text
return
  function(self, IndentValue)
    assert_string(IndentValue)
    self.indent = IndentValue

    self.text = ''
  end
