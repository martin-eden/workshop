-- Set baud rate and read timeout for TTY device

--[[
  Author: Martin Eden
  Last mod.: 2026-04-15
]]

local ToString = request('!.concepts.Words.ToString')
local RunCommand = request('!.mechs.run_command')

--[[
  Set baud rate and read timeout for TTY device given by name

  Non-blocking read means that if we reading ten bytes and
  read only seven bytes, we will try to get remained
  three bytes until timeout. And then return bytes we got.

  Input:

    DeviceName -- File name for device. Like "/dev/ttyUSB0"
    {
      ReadTimeout_S -- [0.1] - Read timeout in seconds
      Speed_Bps -- [115200] - Connection speed
    }
]]
local SetParams =
  function(DeviceName, Params)
    local ReadTimeout_S = Params.ReadTimeout_S
    local Speed_Bps = Params.Speed_Bps

    assert_string(DeviceName)
    ReadTimeout_S = ReadTimeout_S or 0.1
    Speed_Bps = Speed_Bps or 115200

    -- "stty" accepts waiting time in deciseconds
    ReadTimeout_dS = math.floor(ReadTimeout_S * 10)

    --[[
      Kinda long I know. I tried simpler

        stty --file=%s %d -echoctl raw time %d min 0 cs8

      but that didn't work.
    ]]
    local Sentence =
      {
        'stty',
        '--file=' .. DeviceName,
        tostring(Speed_Bps),
        'raw',
        'time',
        tostring(ReadTimeout_dS),
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

    RunCommand(ToString(Sentence))
  end

-- Export:
return SetParams

--[[
  2020 #
  2021 #
  2024 # #
  2026-04-15
]]
