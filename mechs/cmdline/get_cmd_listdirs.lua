-- Return shell command to list all directories in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

-- Imports:
local quote = request('!.concepts.shell.quote')
local glue_words = request('!.concepts.words.to_string')

-- Export:
return
  function(dir_name)
    local Command =
      {
        'find',
        quote(dir_name),
        '-maxdepth',
        '1',
        '-type',
        'd',
      }

    return glue_words(Command)
  end

--[[
  2019 #
  2024 #
  2026-01-12
  2026-04-17
]]
