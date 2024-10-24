-- Concatenate list of string values to string

-- Last mod.: 2024-10-20

return
  function(List, Separator)
    Separator = Separator or ''

    -- Meh, in Lua it's simple
    return table.concat(List, Separator)
  end

--[[
  2024-10-20
  2024-10-24
]]
