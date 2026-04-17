-- Return shell command to change current directory

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

-- Imports:
local <const> quote = request('!.concepts.shell.quote')
local <const> glue_words = request('!.concepts.words.to_string')

-- Export:
return
  function(path)
    local <const> Command =
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
