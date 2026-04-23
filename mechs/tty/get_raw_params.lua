-- Return TTY device parameters as encoded string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

-- Imports:
local glue_words = request('!.concepts.words.to_string')
local run_command = request('!.concepts.shell.execute')

--[[
  Get TTY device parameters as opaque string for later restoration

  Input:

    [s] tty_name -- Device file name

  Output:

    [s] -- Encoded port configuration
]]
local get_tty_params =
  function(tty_name)
    local Command =
      {
        'stty',
        '--file=' .. tty_name,
        '--save',
      }

    return run_command(glue_words(Command)).Output
  end

-- Export:
return get_tty_params

--[[
  2020 #
  2021 #
  2023 #
  2024 #
  2026-04-17
]]
