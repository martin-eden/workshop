-- File interface for UART devices

--[[
  Author: Martin Eden
  Last mod.: 2026-04-28
]]

--[[
  Opens device as file for reading and writing.

  Exports separate input and output channels.

  Opening device "/dev/ttyUSB0" as file requires more work
  than just opening it as file. So this specie.
]]

-- Imports:
local InputInterface = new(request('!.concepts.StreamIo.Input.File'))
local OutputInterface = new(request('!.concepts.StreamIo.Output.File'))

-- Export:
return
  {
    -- [Carnage]
    Open = request('Open'),
    Close = request('Close'),

    -- [Exports]
    Input = InputInterface,
    Output = OutputInterface,

    -- [Internals]
    FileHandle = 0,
    IsConnected = false,
    PortName = '',
    OriginalPortParams = '',
  }

--[[
  2024 # #
  2026-04-15
]]
