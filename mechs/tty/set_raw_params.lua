-- Set TTY device params from opaque string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local glue_words = request('!.concepts.words.to_string')
local shell_execute = request('!.concepts.shell.execute')

--[[
  Set TTY device params from "raw" string

  Stty-readable string usually produced by "$ stty --save".

  Input:

    [s] tty_name -- Device file name
    [s] params -- Encoded configuration
]]
local set_raw_params =
  function(tty_name, params)
    local Command =
      {
        'stty',
        '--file=' .. tty_name,
        params,
      }

    shell_execute(glue_words(Command))
  end

-- Export:
return set_raw_params

--[[
  2020 #
  2021 #
  2023 #
  2024 #
  2026-04-17
]]
