-- File interface for UART devices

-- Last mod.: 2024-11-11

--[[
  Opens device as file for reading and writing.

  Exports separate input and output channels.

  Opening device "/dev/ttyUSB0" as file requires more work
  than just opening it as file. So this specie.
]]

-- Imports:
local InputInterface = new(request('!.concepts.StreamIo.Input.File'))
local OutputInterface = new(request('!.concepts.StreamIo.Output.File'))

-- Exports:
return
  {
    -- [New]

    -- Open device by name
    Open = request('Open'),

    -- Close device
    Close = request('Close'),

    -- [Main]

    -- Read method complied to [StreamIo.Input]
    Read = request('Read'),

    -- Write method complied to [StreamIo.Output]
    Write = request('Write'),

    -- [Exports]

    -- Input interface
    Input = InputInterface,

    -- Output interface
    Output = OutputInterface,

    -- [Internals]
    FileHandle = 0,
    IsConnected = false,
    PortName = '',
    OriginalPortParams = '',
  }

--[[
  2024-09-18
  2024-11-11
]]
