local match_sequence = request('seq')

return
  function(self, rule)
    return match_sequence(self, rule) or true
  end
