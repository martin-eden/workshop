return
  function(self)
    if self.do_fix then
      if self.do_check then
        if not self:check() then
          self:fix()
        end
      else
        self:fix()
      end
    end
    if self.do_check then
      assert(self:check())
    end
  end
