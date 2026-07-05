-- Attach methods table to object

--[[
  Author: Martin Eden
  Last mod.: 2026-07-05
]]

--[[
  This module exists to wrap common code:

    local Object = { Data = { } }
    local Methods = { GetLength = function(Me) return #Me.Data end }

  Instead of

    setmetatable(Object, { __index = Methods })

  We call

    attach_methods(Object, Methods)

  Also it explodes when external code will try to add new field.
]]

local attach_methods =
  function(Object, Methods)
    assert_table(Object)
    assert_table(Methods)

    local Metatable =
      {
        __index = Methods,

        __newindex =
          function()
            error('Table is locked for additions.')
          end,
      }

    setmetatable(Object, Metatable )
  end

-- Export:
return attach_methods

--[[
  2026-05-02
  2026-07-05
]]
