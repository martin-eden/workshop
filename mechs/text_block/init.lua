-- Initialize

--[[
  Author: Martin Eden
  Last mod.: 2026-10-20
]]

local Indent = request('!.concepts.Indent')

local max_indent = 100

return
  function(Me)
    Me.processed_text = { }

    local Indent = Indent.create()
    Indent:SetIndentChunk(Me.indent_chunk)
    Indent:SetMaxIndentLevel(max_indent)
    Indent:SetIndentLevel(Me.next_line_indent)
    Me.Indent = Indent

    Me.line_with_text:init(Me.Indent:ToString())

    Me.num_line_feeds = 0
  end

--[[
  2017 #
  2024 #
  2026 #
  2026-10-20
]]
