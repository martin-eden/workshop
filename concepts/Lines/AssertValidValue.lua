-- Assert that value is string without newlines

-- Last mod.: 2024-10-31

local AssertNoNewlines = request('!.string.assert_no_newlines')

-- Exports:
return
  function(self, String)
    assert_string(String)
    AssertNoNewlines(String)
  end

--[[
  2024-10-31
]]
