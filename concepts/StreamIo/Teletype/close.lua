-- Close UART device opened for reading and writing

--[[
  Author: Martin Eden
  Last mod.: 2026-11-04
]]

local tty_set_raw_params = request('!.mechs.tty.set_raw_params')

--[[
  Close our device and zero internal state
]]

return
  function(Me)
    if not Me[3] then return end

    --[[
      -- io.close(file)

      Avoids device reset upon program exit. Just don't close file!

      Very stupid solution but I want pixels on my LED stripe to
      remain lit upon program termination.

      Curiously enough, I've not encountered problems with dangling
      file handle. Surely it is closed somehow when Lua exits, but
      some other way than via "io.close()" which resets device.
    ]]
    -- io.close(Me[4])
    Me[4] = nil

    Me.Input.File = Me[4]
    Me.Output.File = Me[4]

    tty_set_raw_params(Me[1], Me[3])
    Me[3] = nil

    Me[1] = nil

    Me[2] = false
  end

--[[
  2024-09-18
]]
