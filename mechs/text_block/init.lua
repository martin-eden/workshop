-- Initialize

--[[
  Author: Martin Eden
  Last mod.: 2026-07-05
]]

-- Imports:
local Indent = request('!.concepts.Indent')

local Init =
  function(self)
    self.processed_text = { }

    local Indent = Indent.create()
    Indent:SetIndentChunk(self.indent_chunk)
    Indent.RangePoint:SetValue(self.next_line_indent)
    self.Indent = Indent

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
