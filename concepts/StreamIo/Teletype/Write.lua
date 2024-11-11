-- Write string to UART device. Implements [StreamIo.Output]

-- Last mod.: 2024-11-11

local Write =
  function(self, Data)
    return self.Output:Write(Data)
  end

-- Exports:
return Write

--[[
  2024-09-18
]]
