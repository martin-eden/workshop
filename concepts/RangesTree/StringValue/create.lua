-- Create String Value instance

--[[
  Author: Martin Eden
  Last mod.: 2026-05-02
]]

--[[
  Data structure

    Value [s]
]]

-- Imports:
local attach_methods = request('!.table.attach_methods')
local Methods = request('Methods')

local create =
  function(str)
    str = str or ''

    assert_string(str)

    local Result = { Value = str }

    attach_methods(Result, Methods)

    return Result
  end

-- Export:
return create

--[[
  2026-05-02
]]
