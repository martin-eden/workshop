return
  function(self, node)
    if not node.expr_list then
      self.printer:add_text('return')
    else
      self:process_block_oneline('return', nil, node.expr_list)
    end
  end
