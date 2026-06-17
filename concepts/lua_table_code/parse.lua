-- [Insecure] Execute string with Lua code that expected to return table

--[[
  Author: Martin Eden
  Last mod.: 2026-06-17
]]

local parse =
  function(str)
    local f = load(str)

    if not f then return end

    return (f())
  end

-- Export:
return parse

--[[
  2016
  2026-06-17
]]
