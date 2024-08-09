-- Writes strings to memory. Implements [Writer]

--[[
  Writer over string

                  Chunks
    ---------------------
                | {}
    Write("a")  | {'a'}
    Write("bc") | {'a', 'bc'}
    Write("")   |
    GetString() |
      > "abc"   |
    Aggregate() | {'abc'}
    Flush()     | {}
]]

-- Contract: Write string
local Write =
  function(self, Data)
    assert_string(Data)

    if (Data ~= '') then
      table.insert(self.Chunks, Data)
    end

    return #Data, true
  end

-- Additional: flush chunks
local Flush =
  function(self)
    self.Chunks = {}
  end

-- Additional: return sum of chunks
local GetString =
  function(self)
    return table.concat(self.Chunks)
  end

-- Additional: merge chunks
local Aggregate =
  function(self)
    if (#self.Chunks >= 2) then
      local Data = GetString(self)
      Flush(self)
      self:Write(Data)
    end
  end

return
  {
    -- Interface
    Write = Write,

    -- Intensities
    Chunks = {},

    -- Intensities management
    Flush = Flush,
    GetString = GetString,
    Aggregate = Aggregate,
  }

--[[
  2024-07-19
  2024-07-24
  2024-08-04
  2024-08-09
]]
