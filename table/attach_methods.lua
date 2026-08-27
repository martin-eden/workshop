-- Attach methods table to object

--[[
  Author: Martin Eden
  Last mod.: 2026-08-28
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

-- Export:
return
  function(Object, Methods)
    assert_table(Object)
    assert_table(Methods)

    local Metatable =
      {
        __index = Methods,

        __newindex =
          function()
            error('Table is locked for additions/removals.')
          end,
      }

    setmetatable(Object, Metatable)
  end

--[[
  2026 # #
]]
