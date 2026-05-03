-- Create Bits Value

--[[
  Author: Martin Eden
  Last mod.: 2026-05-02
]]

--[[
  Data structure

    Value [i]
]]

-- Imports:
local attach_methods = request('!.table.attach_methods')
local Methods = request('Methods')

local create =
  function(value)
    value = value or 0

    assert_integer(value)

    local Result = { Value = value }

    attach_methods(Result, Methods)

    return Result
  end

-- Export:
return create

--[[
  2026-05-02
]]
