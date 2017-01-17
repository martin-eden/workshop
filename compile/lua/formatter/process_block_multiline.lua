--[[
  Process indent block with multi-line style.

  multiline samples:
    do
      <>
    end

    return
      <>
]]

return
  function(self, prefix, postfix, node)
    local printer = self.printer

    if prefix then
      printer:add_text(prefix)
    end

    printer:request_clean_line()
    printer:inc_indent()
    self:process_node(node)
    printer:dec_indent()
    printer:request_clean_line()

    if postfix then
      printer:add_text(postfix)
    end
  end
