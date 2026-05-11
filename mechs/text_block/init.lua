-- Initialize

--[[
  Author: Martin Eden
  Last mod.: 2026-05-12
]]

local Init =
  function(self)
    self.processed_text = {}

    self.Indent = self.IndentClass.create()
    self.Indent.indent_chunk = self.indent_chunk
    self.Indent.RangePoint.value = self.next_line_indent

    self.line_with_text:init(self.Indent:ToString())

    self.num_line_feeds = 0
  end

-- Export:
return Init

--[[
  2017 #
  2024 #
  2026-05-12
]]
