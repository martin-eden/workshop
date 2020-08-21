local quote_string = request('^.^.^.quote_string')

return
  function(self, data)
    return quote_string(data)
  end
