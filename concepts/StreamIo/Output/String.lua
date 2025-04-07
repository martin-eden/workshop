-- [Output] stream interface for strings

-- Last mod.: 2025-04-07

--[[
  "Output" interface is just one method: Write(string)

  But string concatenation is expensive in Lua. So Write()
  adds string to internal table.

  To get concatenated string call GetString().
]]

--[[
  Add string to result string
]]
local Write =
  function(self, Data)
    assert_string(Data)

    if (Data ~= '') then
      table.insert(self.Chunks, Data)
    end

    return #Data, true
  end

--[[
  Return result string
]]
local GetString =
  function(self)
    return table.concat(self.Chunks)
  end

-- Exports:
return
  {
    -- [Interface]
    Write = Write,
    GetString = GetString,

    -- [Internals]
    Chunks = {},
  }

--[[
  2024-07 # #
  2024-08 # #
  2025-04-07
]]
