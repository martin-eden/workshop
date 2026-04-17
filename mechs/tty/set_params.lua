-- Set baud rate and read timeout for TTY device

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

-- Imports:
local glue_words = request('!.concepts.words.to_string')
local run_command = request('!.concepts.Shell.Execute')

--[[
  Set baud rate and read timeout for TTY device given by name

  Non-blocking read means that if we reading ten bytes and
  read only seven bytes, we will try to get remained
  three bytes until timeout. And then return bytes we got.

  Input:

    [s] tty_name -- File name for device. Like "/dev/ttyUSB0"
    [t] Params:
      [f] ReadTimeout_S -- [0.1] - Read timeout in seconds
      [i] Speed_Bps -- [115200] - Connection speed
]]
local set_params =
  function(tty_name, Params)
    local <const> read_timeout_s = Params.ReadTimeout_S or 0.1
    local <const> speed_bps = Params.Speed_Bps or 115200

    -- "stty" accepts waiting time in deciseconds
    local <const> read_timeout_ds = math.floor(read_timeout_s * 10)

    --[[
      Kinda long I know. I tried simpler

        stty --file=%s %d -echoctl raw time %d min 0 cs8

      but that didn't work.
    ]]
    local <const> Command =
      {
        'stty',
        '--file=' .. tty_name,
        tostring(speed_bps),
        'raw',
        'time',
        tostring(read_timeout_ds),
        'min',
        '0',
        'cs8',
        '-echo',
        '-echoctl',
        '-echoe',
        '-echok',
        '-echoke',
        '-icanon',
        '-icrnl',
        '-iexten',
        '-isig',
        '-ixon',
        '-opost',
      }

    run_command(glue_words(Command))
  end

-- Export:
return set_params

--[[
  2020 #
  2021 #
  2024 # #
  2026-04-15
]]
