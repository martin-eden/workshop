-- Insert string after line at given index

-- Last mod.: 2024-10-31

-- Exports:
return
  function(self, String, Index)
    --[[
      We can't hire InsertLineBefore() to do this job for us
      because <Index> needs to be (<Index> + 1) and it won't
      be valid.
    ]]

    self:AssertValidValue(String)
    self:AssertValidIndex(Index)

    table.insert(self.Lines, Index + 1, String)
  end

--[[
  2024-10-31
]]
