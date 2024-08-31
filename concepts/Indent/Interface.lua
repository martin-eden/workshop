return
  {
    -- Interface

    -- Initialization setup
    Init =
      function(self, IndentValue, ChunkValue)
        -- Tune counter for our needs
        self.Counter.MinValue = 0
        self.Counter.MaxValue = 1000
        self.Counter:Init(IndentValue)

        -- Set chunk if passed
        if not is_nil(ChunkValue) then
          assert_string(ChunkValue)
          self.Chunk = ChunkValue
        end
      end,

    -- Increase indent
    Increase =
      function(self)
        return self.Counter:Increase()
      end,

    -- Decrease indent
    Decrease =
      function(self)
        return self.Counter:Decrease()
      end,

    -- Return current indent value (integer)
    GetDepth =
      function(self)
        return self.Counter:Get()
      end,

    -- Return current indent string
    GetString =
      function(self)
        return string.rep(self.Chunk, self:GetDepth())
      end,

    -- Intensities

    -- Indent counter
    Counter = request('!.concepts.Counter.Interface'),

    -- Indent chunk
    Chunk = '  ',
  }

--[[
  2024-08-31
]]
