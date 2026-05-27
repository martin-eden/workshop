-- Close UART device opened for reading and writing

--[[
  Author: Martin Eden
  Last mod.: 2026-05-27
]]

-- Imports:
local tty_set_raw_params = request('!.mechs.tty.set_raw_params')

--[[
  Close our device and zero internal state.
]]
local Close =
  function(Me)
    if not Me.is_connected then return end

    --[[
      -- io.close(Me.File)

      Avoiding device reset upon program exit. Just don't close
      file!

      Very stupid solution but I want pixels on my LED stripe to
      remain lit upon program termination.

      Curiously enough, I've not encountered problems with dangling
      file handle. Surely it is closed somehow when Lua exits, but
      some other way than via "io.close()" which resets device.
    ]]
    -- io.close(Me.File)
    Me.File = nil

    Me.Input.File = Me.File
    Me.Output.File = Me.File

    tty_set_raw_params(Me.port_name, Me.original_port_params)
    Me.original_port_params = nil

    Me.port_name = nil

    Me.is_connected = false
  end

-- Exports:
return Close

--[[
  2024-09-18
]]
