-- Convert lines to string

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local list_to_string = request('!.concepts.list.to_string')
local newline = request('!.concepts.ascii.chars').newline

-- Concatenate strings list using newline separator. Tailing newline.
return
  function(lines)
    return list_to_string(lines, newline) .. newline
  end

--[[
  2024 #
  2026-04 #
  2026-05-04
]]
