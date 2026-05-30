-- Return TTY device parameters as encoded string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-30
]]

-- Imports:
local glue_words = request('!.concepts.words.to_string')
local shell_execute = request('!.concepts.shell.execute')

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

    return shell_execute(glue_words(Command)).output
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
