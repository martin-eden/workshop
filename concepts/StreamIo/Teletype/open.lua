-- Open UART device for reading and writing

--[[
  Author: Martin Eden
  Last mod.: 2026-11-04
]]

local read_timeout_sec = 0.1
local warmup_delay_sec = 4.2

local exists = request('!.file_system.file.exists')
local close = request('close')
local tty_get_raw_params = request('!.mechs.tty.get_raw_params')
local tty_set_params = request('!.mechs.tty.set_params')
local sleep_sec = request('!.system.sleep')

return
  function(Me, speed_bps)
    --[[
      Additional steps to open device as file:

        * Set waited read
        * Set connection speed
        * Disable write buffering
        * Wait some time after opening
    ]]

    if not exists(Me[1]) then return end

    if Me[2] then close(Me) end

    Me[3] = tty_get_raw_params(Me[1])

    tty_set_params(
      Me[1],
      { speed_bps = speed_bps, read_timeout_s = read_timeout_sec }
    )

    Me[4] = io.open(Me[1], 'r+')
    Me[4]:setvbuf('no')

    sleep_sec(warmup_delay_sec)

    Me.Input.File = Me[4]
    Me.Output.File = Me[4]

    Me[2] = true

    return true
  end

--[[
  2024 # # #
  2026-04-15
]]
