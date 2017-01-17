local indents_class = request('^.^.^.^.handy_mechs.indents_table')

return
  function(self)
    self.text:init()
    self.next_line_indent = 0
    self.line_indents = {}
    self.on_clean_line = true
    self:update_indent()

    self.indents_obj = new(indents_class)
    self.indents_obj.indent_chunk = self.indent_chunk
    self.indents_obj:init()
  end
