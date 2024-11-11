-- Read from UART device. Implements [StreamIo.Input]

-- Last mod.: 2024-11-11

local Read =
  function(self, NumBytes)
    return self.Input:Read(NumBytes)
  end

-- Exports:
return Read
--[[
  2024-09-18
]]
