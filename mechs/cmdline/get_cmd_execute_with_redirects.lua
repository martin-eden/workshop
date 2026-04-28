-- Return shell command to execute given string with output redirects

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
  function(orig_command, output_file_name, errors_file_name)
    local Command =
      {
        'sh',
        '-c',
        quote(orig_command),
        '1>' .. quote(normalize(output_file_name)),
        '2>' .. quote(normalize(errors_file_name)),
      }

    return glue_words(Command)
  end

--[[
  2026-04-17
  2026-04-28
]]
