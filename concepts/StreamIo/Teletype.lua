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

local close
local open
do
  -- Open UART device for reading and writing

  --[[
    Additional steps to open device as file:

      * Set connection speed
      * Set waited read
      * Disable write buffering
      * Wait some time after opening
  ]]

  --[[
    We are providing input and output streams

    However internally we use input/output file stream classes.
    They work with file handle to do the job.
    We have to patch them with our specially opened file handle.
  ]]

  local read_timeout_sec = 0.1
  local warmup_delay_sec = 4.2

  local exists = request('!.file_system.file.is_byte_stream_device')
  local tty_get_raw_params = request('!.mechs.tty.get_raw_params')
  local tty_set_params = request('!.mechs.tty.set_params')
  local sleep_sec = request('!.system.sleep')
  local InputInterface = request('!.concepts.StreamIo.Input.File')
  local OutputInterface = request('!.concepts.StreamIo.Output.File')

  open =
    function(Me, speed_bps)
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

      Me.Input = InputInterface.create(Me[1])
      Me.Input[2] = Me[4]

      Me.Output = OutputInterface.create(Me[1])
      Me.Output[2] = Me[4]

      Me[2] = true

      return true
    end
end

-- close
do
  --[[
    Close UART device opened for reading and writing

    Zeroes internal state.
  ]]

  local tty_set_raw_params = request('!.mechs.tty.set_raw_params')

  close =
    function(Me)
      if not Me[3] then return end

      --[[
        -- io.close(file)

        Avoids device reset upon program exit. Just don't close file!

        My use case is LED stripe with my firmware.

        "io.close()" resets device: initialization code there runs
        and turns off all LEDs.

        Without this pixels stays lit (and device can be reopened).

        Surely device is closed somehow when Lua exits,
        but some other way than via io.close().
      ]]
      -- io.close(Me[4])
      Me[4] = nil

      Me.Input[2] = Me[4]
      Me.Output[2] = Me[4]

      tty_set_raw_params(Me[1], Me[3])
      Me[3] = nil

      Me[1] = nil

      Me[2] = false
    end
end

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

    Open = open,
    Close = close,

    Input = nil,
    Output = nil,
  }

-- Export:
return Interface

--[[
  2024 # # #
  2026 # #
  2026-11-04
]]
