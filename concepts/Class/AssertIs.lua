-- Raise error if instance does not supports interface

-- Last mod.: 2024-11-11

local Is = request('Is')

return
  function(Instance, Interface)
    if not Is(Instance, Interface) then
      error('Instance does not support interface.')
    end
  end

--[[
  2024-07-19
]]
