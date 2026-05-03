-- Create ranges container

--[[
  Author: Martin Eden
  Last mod.: 2026-05-03
]]

--[[
  Data structure

    Tree map of Range objects by name part
]]

-- Imports:
local attach_methods = request('!.table.attach_methods')
local Methods = request('Methods')

local create =
  function()
    local Result = { }

    attach_methods(Result, Methods)

    return Result
  end

-- Export:
return create

--[[
  2026-05-02
]]
