-- Set baud rate and read timeout for TTY device given by name

-- Last mod.: 2024-10-29

--[[
  Non-blocking read means that if we reading ten bytes and
  receive buffer has only seven bytes, we wait up to given
  amount of time awaiting that three bytes. And then return
  bytes we got.

  In multithreading sense it's still blocking operation.
  But at worst case here we're wasting given amount of time
  versus infinite wait.

  Input:

    string - Port name
    [float] - Read timeout (seconds). Default: 0.1
    [int] - Port baud. Default: 57600
]]

return
  function(
    DeviceName,
    ReadTimeout_S,
    Speed_Bps
  )
    assert_string(DeviceName)

    ReadTimeout_S = ReadTimeout_S or 0.1

    Speed_Bps = Speed_Bps or 57600

    -- "stty" accepts waiting time in deciseconds
    ReadTimeout_dS = math.floor(ReadTimeout_S * 10)

    --[[
      Kinda long I know. I tried simpler

        stty --file=%s %d -echoctl raw time %d min 0 cs8

      but looks like that didn't work. Code was commented.
    ]]
    local CommandFmt =
      'stty' ..
      ' --file=%s' ..
      ' %d' ..
      ' raw' ..
      ' time %d' ..
      ' min 0' ..
      ' cs8' ..
      ' -echo' ..
      ' -echoctl' ..
      ' -echoe' ..
      ' -echok' ..
      ' -echoke' ..
      ' -icanon' ..
      ' -icrnl' ..
      ' -iexten' ..
      ' -isig' ..
      ' -ixon' ..
      ' -opost'

    local Command =
      string.format(
        CommandFmt,
        DeviceName,
        Speed_Bps,
        ReadTimeout_dS
      )

    assert(os.execute(Command))
  end

--[[
  2020-01
  2021-11
  2024-09
  2024-10-29
]]
