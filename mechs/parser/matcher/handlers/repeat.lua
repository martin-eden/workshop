local match_sequence = request('seq')

return
  function(self, rule)
    if match_sequence(self, rule) then
      while match_sequence(self, rule) do
      end
      return true
    end
  end
