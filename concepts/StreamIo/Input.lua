-- Input stream interface

--[[
  Author: Martin Eden
  Last mod.: 2026-05-27
]]

--[[
  Interface

    (
      Read [f]

        Read given amount of bytes to string

        Input:
          [i]: >= 1

        Output:
          [s]
    )
]]

-- Imports:
local is_natural = request('!.number.is_natural')

local Interface =
  {
    Read =
      function(Me, num_bytes)
        assert(is_natural(num_bytes))

        return ''
      end,
  }

-- Export:
return Interface

--[[
  2024 # #
  2026-05-27
]]
