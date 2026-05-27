-- File interface for serial devices

--[[
  Author: Martin Eden
  Last mod.: 2026-05-27
]]

--[[
  Opens device as file for reading and writing.

  Exports separate input and output streams.

  Opening device "/dev/ttyUSB0" as file requires more work
  than just opening file. So this specie.
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
    File = nil,
    is_connected = false,
    port_name = '',
    original_port_params = '',
  }

--[[
  2024 # #
  2026-04-15
  2026-05-27
]]
