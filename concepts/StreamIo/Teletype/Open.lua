-- Open UART device by name

--[[
  Author: Martin Eden
  Last mod.: 2026-04-15
]]

local Config =
  {
    ReadTimeout_Sec = 0.1,
    WarmupDelay_Sec = 3.5,
  }

-- Imports:
local FileExists = request('!.file_system.file.exists')
local GetRawParams = request('!.mechs.tty.get_raw_params')
local SetParams = request('!.mechs.tty.set_params')
local SleepSec = request('!.system.sleep')

--[[
  Open port both for reading and writing.

  In case of errors explodes.
]]
local Open =
  function(self, PortName, Speed_Bps)
    --[[
      Additional steps to open device as file:

        * Set waited read
        * Set connection speed
        * Disable write buffering
        * Wait some time after opening
    ]]

    assert_string(PortName)

    if not FileExists(PortName) then
      error(string.format("Can't see device '%s'.", PortName))
    end

    self.PortName = PortName

    if self.IsConnected then
      self:Close()
    end

    self.OriginalPortParams = GetRawParams(PortName)

    SetParams(
      PortName,
      {
        Speed_Bps = Speed_Bps,
        ReadTimeout_S = Config.ReadTimeout_Sec,
      }
    )

    self.FileHandle = io.open(PortName, 'r+')

    self.FileHandle:setvbuf('no')

    self.Input.FileHandle = self.FileHandle
    self.Output.FileHandle = self.FileHandle

    self.IsConnected = true

    SleepSec(Config.WarmupDelay_Sec)
  end

-- Exports:
return Open

--[[
  2024 # # #
  2026-04-15
]]
