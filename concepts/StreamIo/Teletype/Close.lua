-- Close UART device opened for reading and writing

--[[
  Author: Martin Eden
  Last mod.: 2026-04-15
]]

local SetRawParams = request('!.mechs.tty.set_raw_params')

--[[
  Close our device and zero internal state.
]]
local Close =
  function(self)
    if not self.IsConnected then
      return
    end

    --[[
      -- io.close(self.FileHandle)

      Avoiding device reset upon program exit. Just don't close
      file!

      Very stupid solution but I want pixels on my LED stripe to
      remain lit upon program termination.

      Curiously enough, I've not encountered problems with dangling
      file handle. Surely it is closed somehow when Lua exits, but
      some other way than via "io.close()" which resets device.
    ]]
    -- io.close(self.FileHandle)
    self.FileHandle = nil

    self.Input.FileHandle = nil
    self.Output.FileHandle = nil

    SetRawParams(self.PortName, self.OriginalPortParams)
    self.OriginalPortParams = nil

    self.PortName = nil

    self.IsConnected = false
  end

-- Exports:
return Close

--[[
  2024-09-18
]]
