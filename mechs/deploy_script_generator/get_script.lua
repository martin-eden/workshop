-- Generate string with deploy script

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

-- Export:
return
  function(Me)
    return Me.bash_script_writer:GetScript()
  end

--[[
  2018
  2026-05-28
]]
