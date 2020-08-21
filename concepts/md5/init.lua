local clone = request('!.table.clone')

return
  function(self)
    self.hash = clone(self.starting_hash)
  end
