-- Output stream on string

--[[
  Author: Martin Eden
  Last mod.: 2026-08-28
]]

--[[
  String concatenation is time-expensive in Lua.
  So Write() adds strings to internal table.
  That's memory-expensive.
]]

local list_to_string = request('!.concepts.list.to_string')
local list_add_item = request('!.concepts.list.add_item')

-- Export:
return
  {
    -- [Required extension]
    GetString =
      function(Me)
        return list_to_string(Me.Chunks)
      end,

    -- [Base]
    Write =
      function(Me, data_str)
        assert_string(data_str)
        assert(data_str ~= '')

        list_add_item(Me.Chunks, data_str)
      end,

    -- [Internal]
    Chunks = { },
  }

--[[
  2024 # # # #
  2025 #
  2026-05-27
]]
