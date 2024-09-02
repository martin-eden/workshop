-- Writes strings to memory. Implements [Output]

--[[
  Implementation

  Example
                  Chunks
    ---------------------
                | {}
    Write("a")  | {'a'}
    Write("bc") | {'a', 'bc'}
    Write("")   | ditto
    GetString() | ditto
      > "abc"   |
    Aggregate() | {'abc'}
    Flush()     | {}

  Data

    Chunks: {}

      List of strings.

  Methods

    Write(string): int, bool

      Actually adds string to chunks.

    GetString(): str

      Returns string as chunks concatenation.

    Flush()

      Empties chunks.

    Aggregate()

      Merges several chunks to one
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

-- Intestines: flush chunks
local Flush =
  function(self)
    self.Chunks = {}
  end

-- Intestines: return sum of chunks
local GetString =
  function(self)
    return table.concat(self.Chunks)
  end

-- Intestines: merge chunks
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

    -- Intestines
    Chunks = {},

    -- Intestines management
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
