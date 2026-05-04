-- Merge lines to string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Imports:
local list_to_string = request('!.concepts.list.to_string')

local delimiter = '\n'

-- Concatenate strings list using newline separator. Tailing newline.
local lines_to_str =
  function(Lines)
    return (list_to_string(Lines, delimiter) .. delimiter)
  end

-- Export:
return lines_to_str

--[[
  Good design is not about implementing complex things.
  Good design is providing uniform interface to many things.

  2024-02-28, 2024-03-02
]]

--[[
  2024 #
  2026-04 #
  2026-05-04
]]
