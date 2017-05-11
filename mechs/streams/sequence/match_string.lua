return
  function(self, str)
    local slot_value = self:block_read(1)
    return (slot_value == str)
  end
