-- [Insecure] Parse string as Lua table

--[[
  Author: Martin Eden
  Last mod.: 2026-06-16
]]

-- This is not secure method. But very simple and fast

local parse =
  function(str)
    local chunk = 'return ' .. str

    local f = load(chunk)

    if not f then return end

    return (f())
  end

-- Export:
return parse

--[[
  2016 # #
  2026-06-16
]]
