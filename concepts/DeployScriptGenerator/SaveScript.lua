-- Generate deploy script and save it to file

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

-- Imports:
local file_from_str = request('!.convert.file_from_str')

local SaveScript =
  function(Me, script_filename)
    script_filename = script_filename or 'deploy.sh'

    local script_str = Me.BashScriptWriter:GetScript()

    file_from_str(script_str, script_filename)
  end

-- Export:
return SaveScript

--[[
  2018
  2026-05-28
]]
