return
  function(self)
    local result = {}
    repeat
      local rec = self:get_next_rec()
      result[#result + 1] = rec
    until not rec
    return result
  end
