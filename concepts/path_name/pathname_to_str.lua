-- Compile list of names to directory path

--[[
  Author: Martin Eden
  Last mod.: 2026-08-29
]]

local sep = request('Syntels').separator
local list_to_str = request('!.concepts.list.to_string')

-- Export:
return
  function(Pathname)
    return list_to_str(Pathname, sep)
  end

--[[
  2026 #
]]
