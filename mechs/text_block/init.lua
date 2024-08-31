return
  function(self)
    self.processed_text = {}

    self.Indent:Init(self.next_line_indent, self.indent_chunk)

    self.line_with_text:init(self.Indent:GetString())

    self.num_line_feeds = 0
  end
