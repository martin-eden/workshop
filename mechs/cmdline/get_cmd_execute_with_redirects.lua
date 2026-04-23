-- Return shell command to execute given string with output redirects

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

-- Imports:
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
        '1>' .. output_file_name,
        '2>' .. errors_file_name,
      }

    return glue_words(Command)
  end

--[[
  2026-04-17
]]
