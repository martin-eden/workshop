-- Return number of lines

-- Last mod.: 2024-10-31

--[[
  It may seem stupid..

  We don't use private fields. We store lines at <.Lines>.
  You can just #<.Lines> to get length.

  But we want freedom to rename our "Lines" field. Or even change it
  to some object. So good code is:

    Lines:FromString('123\n456')
    if Lines:IsOneLine() then
      io.write('( ', Lines:GetFirstLine(), ' )\n')
    else
      Lines:Indent()
      Lines:AddStringToStart('(')
      Lines:AddStringToEnd(')')
      io.write(Lines:ToString())
    end
]]

-- Exports:
return
  function(self)
    return #self.Lines
  end

--[[
  2024-10-31
]]
