return
  function(self, node)
    -- assert_table(node)
    if is_table(node) then
      local node_type = node.type or '?nil'
      local handler = self.handlers[node_type]
      if handler then
        handler(self, node)
      else
        self.printer:emit('<' .. node_type .. '>')
      end
    end
  end
