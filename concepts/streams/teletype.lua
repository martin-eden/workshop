-- File interface for serial devices

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
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
  local io_open = io.open
  local sleep_sec = request('!.system.sleep')
  local file_in_stream = request('!.concepts.streams.input.file')
  local file_out_stream = request('!.concepts.streams.output.file')

  open =
    function(me, speed_bps)
      local dev_name = me[1]

      if not exists(dev_name) then return end

      if me[2] then close(me) end

      me[3] = tty_get_raw_params(dev_name)

      tty_set_params(
        dev_name,
        { speed_bps = speed_bps, read_timeout_s = read_timeout_sec }
      )

      me[4] = io_open(dev_name, 'r+')
      me[4]:setvbuf('no')

      sleep_sec(warmup_delay_sec)

      me.input = file_in_stream.create(me[1])
      me.input[2] = me[4]

      me.output = file_out_stream.create(me[1])
      me.output[2] = me[4]

      me[2] = true

      return true
    end
end

do
  --[[
    Close UART device opened for reading and writing

    Zeroes internal state.
  ]]

  local tty_set_raw_params = request('!.mechs.tty.set_raw_params')
  close =
    function(me)
      if not me[3] then return end

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
      -- io.close(me[4])
      me[4] = nil

      me.input[2] = me[4]
      me.output[2] = me[4]

      tty_set_raw_params(me[1], me[3])
      me[3] = nil

      me[1] = nil

      me[2] = false
    end
end

local interface
local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function(device_file_name)
      assert_string(device_file_name)
      local me = { device_file_name, false, '', 0 }
      attach_methods(me, interface)
      return me
    end
end

interface =
  {
    create = create,
    open = open,
    close = close,
    input = { },
    output = { },
  }

-- Export:
return interface

--[[
  2024 # # #
  2026 # #
  2026-11-04
]]
