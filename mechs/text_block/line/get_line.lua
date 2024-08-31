-- Return string with indent and text
return
  function(self)
    if self:is_empty() then
      return ''
    end

    return self.indent .. self.text
  end
