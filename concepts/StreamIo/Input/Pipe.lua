-- Input stream on standard input

--[[
  Author: Martin Eden
  Last mod.: 2026-05-27
]]

-- Imports:
local is_natural = request('!.number.is_natural')

local Interface =
  {
    Read =
      function(Me, num_bytes)
        assert(is_natural(num_bytes))

        local data_str = io.stdin:read(num_bytes)

        -- No end-of-file concept in input stream
        if is_nil(data_str) then data_str = '' end

        return data_str
      end,
  }

-- Export:
return Interface

--[[
  2024 # #
  2026-05-27
]]
