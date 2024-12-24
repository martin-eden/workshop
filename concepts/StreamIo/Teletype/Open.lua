-- Open UART device by name

-- Last mod.: 2024-12-24

local Config =
  {
    ReadTimeout_Sec = 0.1,
    WarmupDelay_Sec = 3.5,
  }

-- Imports:
local FileExists = request('!.file_system.file.exists')
local GetPortParams = request('!.mechs.tty.get_port_params')
local SetNonBlockingRead = request('!.mechs.tty.set_non_blocking_read')
local SleepSec = request('!.system.sleep')

--[[
  Additional steps to open device as file:

    * Set waited read
    * Set connection speed
    * Disable write buffering
    * Wait some time after opening
]]

--[[
  Open port both for reading and writing.

  In case of errors explodes.
]]
local Open =
  function(self, PortName, Speed_Bps)
    assert_string(PortName)
    assert_integer(Speed_Bps)

    if not FileExists(PortName) then
      error(string.format("Can't see device '%s'.", PortName))
    end

    self.PortName = PortName

    if self.IsConnected then
      self:Close()
    end

    self.OriginalPortParams = GetPortParams(PortName)

    SetNonBlockingRead(PortName, Config.ReadTimeout_Sec, Speed_Bps)

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
  2024-09-18
  2024-10-24 setvbuf('no')
  2024-12-24 no default speed
]]
