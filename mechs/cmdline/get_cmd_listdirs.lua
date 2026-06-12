-- Return shell command to list all directories in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

-- Imports:
local normalize = request('!.concepts.path_name.normalize')
local quote = request('!.concepts.shell.quote')
local glue_words = request('!.concepts.words.to_string')

-- Export:
return
  function(dir_name)
    local Command =
      {
        'find',
        quote(normalize(dir_name)),
        '-maxdepth',
        '1',
        '-mindepth',
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
  2026-04-26
  2026-04-28
  2026-06-04
]]
