-- Convert lines to string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

-- Imports:
local list_to_string = request('!.concepts.list.to_string')

-- Concatenate strings list using newline separator. Tailing newline.
local lines_to_str =
  function(Lines)
    local newline = '\n'

    return list_to_string(Lines, newline) .. newline
  end

-- Export:
return lines_to_str

--[[
  2024 #
  2026-04 #
  2026-05-04
]]
