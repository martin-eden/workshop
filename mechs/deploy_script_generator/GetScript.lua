-- Generate string with deploy script

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

local GetScript =
  function(Me)
    return Me.BashScriptWriter:GetScript()
  end

-- Export:
return GetScript

--[[
  2018
  2026-05-28
]]
