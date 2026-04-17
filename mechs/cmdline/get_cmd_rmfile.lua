-- Return shell command to remove file by pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

-- Imports:
local <const> quote = request('!.concepts.shell.quote')
local <const> glue_words = request('!.concepts.words.to_string')

-- Export:
return
  function(file_name)
    local <const> Command =
      {
        'rm',
        quote(file_name),
      }

    return glue_words(Command)
  end

--[[
  2024 # #
  2026-01-12
  2026-04-17
]]
