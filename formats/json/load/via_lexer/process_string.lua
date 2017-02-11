local unquote_string = request('^.unquote_string')

return
  function(self, s)
    return unquote_string(s)
  end
