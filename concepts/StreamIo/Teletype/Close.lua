-- Close UART device opened for reading and writing

--[[
  Author: Martin Eden
  Last mod.: 2026-04-28
]]

-- Imports:
local tty_set_raw_params = request('!.mechs.tty.set_raw_params')

--[[
  Close our device and zero internal state.
]]
local Close =
  function(Me)
    if not Me.IsConnected then
      return
    end

    --[[
      -- io.close(Me.FileHandle)

      Avoiding device reset upon program exit. Just don't close
      file!

      Very stupid solution but I want pixels on my LED stripe to
      remain lit upon program termination.

      Curiously enough, I've not encountered problems with dangling
      file handle. Surely it is closed somehow when Lua exits, but
      some other way than via "io.close()" which resets device.
    ]]
    -- io.close(Me.FileHandle)
    Me.FileHandle = nil

    Me.Input.FileHandle = nil
    Me.Output.FileHandle = nil

    tty_set_raw_params(Me.PortName, Me.OriginalPortParams)
    Me.OriginalPortParams = nil

    Me.PortName = nil

    Me.IsConnected = false
  end

-- Exports:
return Close

--[[
  2024-09-18
]]
