-- Output stream on standard output

--[[
  Author: Martin Eden
  Last mod.: 2026-08-30
]]

local Interface =
  {
    Write =
      function(Me, data_str)
        assert_string(data_str)

        io.stdout:write(data_str)
      end,
  }

-- Export:
return Interface

--[[
  2024 # #
  2026-05-27
  2026-08-30
]]
