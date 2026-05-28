-- Generate deploy script and save it to file

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

-- Imports:
local file_from_str = request('!.convert.file_from_str')

local SaveScript =
  function(Me, script_name)
    script_name = script_name or 'deploy.sh'

    local script = Me.bash_script_writer:GetScript()

    file_from_str(script, script_name)
  end

-- Export:
return SaveScript

--[[
  2018
  2026-05-28
]]
