-- Return shell command to sleep for given amount of seconds

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

-- Imports:
local glue_words = request('!.concepts.words.to_string')

-- Export:
return
  function(seconds)
    -- Seconds may be fractional number
    local Command =
      {
        'sleep',
        string.format('%.2f', seconds),
      }

    return glue_words(Command)
  end

--[[
  2020 #
  2026-04-17
]]
