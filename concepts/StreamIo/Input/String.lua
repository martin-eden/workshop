-- Input stream on string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-27
]]

-- Imports:
local is_natural = request('!.number.is_natural')

local Interface =
  {
    -- [Main]
    Read =
      function(Me, num_bytes)
        assert(is_natural(num_bytes))

        local start_pos = Me.read_pos
        local end_pos =
          math.min(start_pos + num_bytes - 1, Me.data_len)

        Me.read_pos = end_pos + 1

        return string.sub(Me.data_str, start_pos, end_pos)
      end,

    -- [Required extension]
    Init =
      function(Me, arg_data_str)
        assert_string(arg_data_str)

        Me.data_str = arg_data_str
        Me.data_len = string.len(Me.data_str)
        Me.read_pos = 1
      end,

    -- [Internals]:
    data_str = '',
    data_len = 0,
    read_pos = 1,
  }

-- Export:
return Interface

--[[
  2024 # #
  2025 #
  2026-05-27
]]
