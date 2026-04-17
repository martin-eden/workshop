-- Set TTY device params from opaque string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

-- Imports:
local glue_words = request('!.concepts.words.to_string')
local run_command = request('!.concepts.Shell.Execute')

--[[
  Set TTY device params from "raw" string

  Stty-readable string usually produced by "$ stty --save".

  Input:

    [s] tty_name -- Device file name
    [s] params -- Encoded configuration
]]
local <const> set_raw_params =
  function(tty_name, params)
    local <const> Command =
      {
        'stty',
        '--file=' .. tty_name,
        params,
      }

    run_command(glue_words(Command))
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
