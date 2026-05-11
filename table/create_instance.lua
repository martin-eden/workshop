-- Create instance of class

--[[
  Author: Martin Eden
  Last mod.: 2026-05-11
]]

-- Imports:
local clone = request('clone')
local attach_methods = request('attach_methods')

local create_instance =
  function(Data, Methods)
    assert_table(Data)
    assert_table(Methods)

    local Result
    Result = clone(Data)
    attach_methods(Result, Methods)

    return Result
  end

-- Export:
return create_instance

--[[
  2026-05-11
]]
