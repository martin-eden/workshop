-- Output stream on string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-27
]]

--[[
  Output interface is just one method: Write(string)

  String concatenation is expensive in Lua.
  So Write() adds strings to internal table.

  Call GetString() to get result string.
]]

-- Imports:
local list_add_item = request('!.concepts.list.add_item')
local list_to_string = request('!.concepts.list.to_string')

local Interface =
  {
    -- [Main]
    Write =
      function(Me, data_str)
        assert_string(data_str)
        assert(data_str ~= '')

        list_add_item(Me.Chunks, data_str)
      end,

    -- [Required extension]
    GetString =
      function(Me)
        return list_to_string(Me.Chunks)
      end,

    -- [Internal]
    Chunks = { },
  }

-- Export:
return Interface

--[[
  2024 # # # #
  2025 #
  2026-05-27
]]
