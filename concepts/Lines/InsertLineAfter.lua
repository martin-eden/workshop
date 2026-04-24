-- Insert string after line at given index

--[[
  Author: Martin Eden
  Last mod.: 2026-04-24
]]

-- Imports:
local trim_tail_newlines = request('!.string.trim_linefeed')

-- Exports:
return
  function(Me, str, index)
    --[[
      We can't hire InsertLineBefore() to do this job for us
      because <Index> needs to be (<Index> + 1) and it won't
      be valid.
    ]]

    Me:AssertValidValue(str)
    Me:AssertValidIndex(index)

    str = trim_tail_newlines(str)

    table.insert(Me.Lines, index + 1, str)
  end

--[[
  2024-10-31
  2026-04-24
]]
