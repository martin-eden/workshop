-- Output stream interface

--[[
  Author: Martin Eden
  Last mod.: 2026-05-27
]]

--[[
  Interface

    (
      Write [f]

        Write bytes from string

        Input:
          [s]: != ""

        Output:
          ∅
    )
]]

local Interface =
  {
    Write =
      function(Me, data_str)
        assert_string(data_str)
        assert(data_str ~= '')
      end,
  }

-- Export:
return Interface

--[[
  2024 # #
  2026-05-27
]]
