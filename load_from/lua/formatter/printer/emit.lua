return
  function(self, s)
    if self.has_debt then
      self.string_adder:add_term(self:get_indent())
      self.has_debt = false
    end
    self.string_adder:add_term(s)
  end

