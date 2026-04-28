-- Return shell command to remove file by pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

-- Imports:
local normalize = request('!.file_system.file.normalize_name')
local quote = request('!.concepts.shell.quote')
local glue_words = request('!.concepts.words.to_string')

-- Export:
return
  function(file_name)
    local Command =
      {
        'rm',
        quote(normalize(file_name)),
      }

    return glue_words(Command)
  end

--[[
  2024 # #
  2026-01-12
  2026-04-17
  2026-04-28
]]
