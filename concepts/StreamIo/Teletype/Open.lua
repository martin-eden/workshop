-- Open UART device by name

--[[
  Author: Martin Eden
  Last mod.: 2026-04-28
]]

local Config =
  {
    ReadTimeout_Sec = 0.1,
    WarmupDelay_Sec = 4.2,
  }

-- Imports:
local file_exists = request('!.file_system.file.exists')
local tty_get_raw_params = request('!.mechs.tty.get_raw_params')
local tty_set_params = request('!.mechs.tty.set_params')
local sleep_sec = request('!.system.sleep')

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

    if not file_exists(device_file_name) then
      error(string.format("Can't see device '%s'.", device_file_name))
    end

    Me.PortName = device_file_name

    if Me.IsConnected then
      Me:Close()
    end

    Me.OriginalPortParams = tty_get_raw_params(device_file_name)

    tty_set_params(
      device_file_name,
      {
        Speed_Bps = speed_bps,
        ReadTimeout_S = Config.ReadTimeout_Sec,
      }
    )

    Me.FileHandle = io.open(device_file_name, 'r+')

    Me.FileHandle:setvbuf('no')

    Me.Input.FileHandle = Me.FileHandle
    Me.Output.FileHandle = Me.FileHandle

    Me.IsConnected = true

    sleep_sec(Config.WarmupDelay_Sec)
  end

-- Exports:
return Open

--[[
  2024 # # #
  2026-04-15
]]
