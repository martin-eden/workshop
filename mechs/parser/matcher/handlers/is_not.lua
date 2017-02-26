local match_choice = request('choice_first')

return
  function(self, rule)
    return not match_choice(self, rule)
  end
