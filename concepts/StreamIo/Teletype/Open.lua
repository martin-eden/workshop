-- Open UART device by name

--[[
  Author: Martin Eden
  Last mod.: 2026-05-27
]]

-- Imports:
local file_exists = request('!.file_system.file.exists')
local tty_get_raw_params = request('!.mechs.tty.get_raw_params')
local tty_set_params = request('!.mechs.tty.set_params')
local sleep_sec = request('!.system.sleep')

local Config =
  {
    read_timeout_sec = 0.1,
    warmup_delay_sec = 4.2,
  }

--[[
  Open port both for reading and writing.

  In case of errors explodes.
]]
local Open =
  function(Me, device_file_name, speed_bps)
    --[[
      Additional steps to open device as file:

        * Set waited read
        * Set connection speed
        * Disable write buffering
        * Wait some time after opening
    ]]

    assert_string(device_file_name)

    if not file_exists(device_file_name) then return false end

    Me.port_name = device_file_name

    if Me.is_connected then Me:Close() end

    Me.original_port_params = tty_get_raw_params(device_file_name)

    tty_set_params(
      device_file_name,
      {
        speed_bps = speed_bps,
        read_timeout_s = Config.read_timeout_sec,
      }
    )

    Me.File = io.open(device_file_name, 'r+')

    Me.File:setvbuf('no')

    Me.Input.File = Me.File
    Me.Output.File = Me.File

    sleep_sec(Config.warmup_delay_sec)

    Me.is_connected = true

    return true
  end

-- Export:
return Open

--[[
  2024 # # #
  2026-04-15
]]
