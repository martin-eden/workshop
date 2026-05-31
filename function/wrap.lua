-- Wrap function call with functions called before and after

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

local wrap =
  function(func, Args, func_before, func_after)
    assert_function(func)
    assert_table(Args)

    if is_function(func_before) then
      Args = table.pack(func_before(table.unpack(Args)))
    end

    local FuncResults = table.pack(func(table.unpack(Args)))

    if is_function(func_after) then
      FuncResults = table.pack(func_after(table.unpack(FuncResults)))
    end

    return table.unpack(FuncResults)
  end

-- Export:
return wrap

--[[
  2026-05-31
]]
