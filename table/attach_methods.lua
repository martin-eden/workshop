-- Attach methods table to object

--[[
  Author: Martin Eden
  Last mod.: 2026-05-02
]]

--[[
  This module exists to wrap common code:

    local Object = { Data = { } }
    local Methods = { GetLength = function(Me) return #Me.Data end }

    -- setmetatable(Object, { __index = Methods })

    attach_methods(Object, Methods)
]]

local attach_methods =
  function(Object, Methods)
    assert_table(Object)
    assert_table(Methods)

    setmetatable(Object, { __index = Methods } )
  end

-- Export:
return attach_methods

--[[
  2026-05-02
]]
