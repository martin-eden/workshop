return
  function(self, node)
    local term
    for term_idx = 1, #node do
      term = node[term_idx]
      if term.un_ops then
        local cur_un_op, prev_un_op
        for i = 1, #term.un_ops do
          cur_un_op = term.un_ops[i]
          if (prev_un_op == '-') and (cur_un_op == '-') then
            self.printer:emit(' -')
          elseif (cur_un_op == 'not') then
            self.printer:emit('not ')
          else
            self.printer:emit(cur_un_op)
          end
          prev_un_op = cur_un_op
        end
      end
      self:process_node(term.operand)
      if term.bin_op then
        self.printer:emit(' ' .. term.bin_op .. ' ')
      end
    end
  end
