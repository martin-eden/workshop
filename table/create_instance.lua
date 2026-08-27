-- Create instance of class

--[[
  Author: Martin Eden
  Last mod.: 2026-08-28
]]

local clone = request('clone')
local attach_methods = request('attach_methods')

-- Export:
return
  function(Data, Methods)
    assert_table(Data)
    assert_table(Methods)

    local Result
    Result = clone(Data)
    attach_methods(Result, Methods)

    return Result
  end

--[[
  2026 #
]]
