-- Comment printer

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

local trim_tail_nls = request('!.string.trim_tail_nls')

return
  function(self, node)
    --[[
      Line comments include tail newline

      Newline is automatically added after any statement.
      Comment is considered a statement.

      So quick fix is to trim tail newline from comment.
    ]]
    self.printer:add_curline(trim_tail_nls(node.value))

    return true
  end

--[[
  2018-02
]]
