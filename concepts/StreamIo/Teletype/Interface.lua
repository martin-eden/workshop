-- File interface for serial devices

--[[
  Author: Martin Eden
  Last mod.: 2026-11-04
]]

--[[
  Opens device as file for reading and writing.

  Exports separate input and output streams.

  Opening device "/dev/ttyUSB0" as file requires more work
  than just opening file. So this specie.
]]

--[[
  Storage format

    1 [s] -- device file name
    2 [b] -- is opened
    3 [s] -- original port parameters
    4 [u] -- file handle
]]

local InputInterface = new(request('!.concepts.StreamIo.Input.File'))
local OutputInterface = new(request('!.concepts.StreamIo.Output.File'))

local Interface
local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function(device_file_name)
      local Me = { device_file_name }
      attach_methods(Me, Interface)
      return Me
    end
end

Interface =
  {
    create = create,

    Open = request('open'),
    Close = request('close'),

    Input = InputInterface,
    Output = OutputInterface,
  }

-- Export:
return Interface

--[[
  2024 # #
  2026 # #
  2026-11-04
]]
