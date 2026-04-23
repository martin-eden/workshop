-- Return shell command to change current directory

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

-- Imports:
local quote = request('!.concepts.shell.quote')
local glue_words = request('!.concepts.words.to_string')

-- Export:
return
  function(path)
    local Command =
      {
        'cd',
        quote(path),
      }

    return glue_words(Command)
  end

--[[
  2024 # #
  2026-01-12
  2026-04-17
]]
