-- Raise error if instance does not supports interface

-- Last mod.: 2024-07-19

local Is = request('Is')

return
  function(Instance, Interface)
    if not Is(Instance, Interface) then
      local ErrorMsg =
        ('Instance %s does not support interface %s.'):
        format(tostring(Instance), tostring(Interface))
      error(ErrorMsg)
    end
  end
