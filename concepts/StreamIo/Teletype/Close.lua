-- Close UART device opened for reading and writing

-- Last mod.: 2024-11-11

local SetPortParams = request('!.mechs.tty.set_port_params')

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

    SetPortParams(self.PortName, self.OriginalPortParams)
    self.OriginalPortParams = nil

    self.PortName = nil

    self.IsConnected = false
  end

-- Exports:
return Close

--[[
  2024-09-18
]]
