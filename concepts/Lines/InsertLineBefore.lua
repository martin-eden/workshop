-- Insert string before line at given index

-- Last mod.: 2024-10-31

--[[
  Method is named "Insert Line Before", but requires string?

  Yes, not "Insert String Before". Because we're adding line
  (string with newline). Argument is string, yes. But it can
  be whatever type we want.

  We're naming function by what it does, not by what arguments
  it accepts.
]]

-- Exports:
return
  function(self, String, Index)
    self:AssertValidValue(String)
    self:AssertValidIndex(Index)

    table.insert(self.Lines, Index, String)
  end

--[[
  2024-10-31
]]
