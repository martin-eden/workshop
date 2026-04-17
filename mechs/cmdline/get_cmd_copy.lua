-- Return shell command to copy file to another name/location.

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

-- Imports:
local <const> quote = request('!.concepts.shell.quote')
local <const> glue_words = request('!.concepts.words.to_string')

-- Export:
return
  function(src_name, dest_name)
    local <const> Command =
      {
        'cp',
        quote(src_name),
        quote(dest_name),
      }

    return glue_words(Command)
  end

--[[
  2018-02-05
  2024-10-21
  2026-01-12
  2026-04-17
]]
