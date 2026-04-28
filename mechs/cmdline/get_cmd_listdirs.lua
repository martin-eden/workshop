-- Return shell command to list all directories in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-04-28
]]

-- Imports:
local normalize = request('!.file_system.file.normalize_name')
local quote = request('!.concepts.shell.quote')
local glue_words = request('!.concepts.words.to_string')

-- Export:
return
  function(dir_name)
    local Command =
      {
        'find',
        quote(normalize(dir_name)),
        '-type',
        'd',
        '-maxdepth',
        '1',
        '-mindepth',
        '1',
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
]]
