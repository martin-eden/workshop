return
  function(self, printer_to_add, do_glue_border_lines)
    if do_glue_border_lines then
      self:add_text(printer_to_add.text.lines[1])
    else
      self.text.lines[#self.text.lines + 1] = printer_to_add.text.lines[1]
      self.line_indents[#self.line_indents + 1] = printer_to_add.line_indents[1]
    end
    for i = 2, #printer_to_add.text.lines do
      self.text.lines[#self.text.lines + 1] = printer_to_add.text.lines[i]
      self.line_indents[#self.line_indents + 1] = printer_to_add.line_indents[i]
    end
  end
