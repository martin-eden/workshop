-- Return shell command to delete directory

--[[
  Author: Martin Eden
  Last mod.: 2026-04-25
]]

-- Imports:
local quote = request('!.concepts.shell.quote')
local glue_words = request('!.concepts.words.to_string')

-- Export:
return
  function(dir_name)
    local Command =
      {
        'rm',
        '-r',
        '-f',
        quote(dir_name),
      }

    return glue_words(Command)
  end


--[[
  2018 #
  2024 # #
  2026-01-12
  2026-04-17
]]
