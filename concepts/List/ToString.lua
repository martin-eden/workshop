-- Concatenate list of string values to string

-- Last mod.: 2024-10-20

--[[
  Implementer may or may not check input arguments.

  Usually implementer do check input parameters for convenience of
  debugging. But for performance reasons it may not check them.

  If something explodes we blame party that violated contract.
  Contract is stated in comments. If comment says you should pass
  string and you passed table, take the blame.
]]

return
  function(List)
    -- Meh, in Lua it's simple
    return table.concat(List)
  end

--[[
  2024-10-20
]]
