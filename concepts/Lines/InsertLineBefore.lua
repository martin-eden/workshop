-- Insert string before line at given index

--[[
  Author: Martin Eden
  Last mod.: 2026-04-24
]]

--[[
  Method is named "Insert Line Before", but requires string?

  Yes, not "Insert String Before". Because we're adding line
  (string with newline). Argument is string, yes. But it can
  be whatever type we want.

  We're naming function by what it does, not by what arguments
  it accepts.
]]

-- Imports:
local trim_tail_newlines = request('!.string.trim_linefeed')

-- Exports:
return
  function(Me, str, index)
    Me:AssertValidValue(str)
    Me:AssertValidIndex(index)

    str = trim_tail_newlines(str)

    table.insert(Me.Lines, index, str)
  end

--[[
  2024-10-31
  2026-04-24
]]
