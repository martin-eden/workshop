-- Output stream on string

--[[
  Author: Martin Eden
  Last mod.: 2026-10-14
]]

--[[
  String concatenation is time-expensive in Lua.
  So Write() adds strings to internal table.
  That's memory-expensive.
]]

--[[
  Storage format

    [t] -- list with string chunks
]]

local write
do
  local add_to = request('!.concepts.list.add_item')
  write =
    function(Me, data_str)
      assert_string(data_str)
      add_to(Me, data_str)
    end
end

local get_string
do
  local list_to_string = request('!.concepts.list.to_string')
  get_string =
    function(Me)
      return list_to_string(Me)
    end
end

local Interface
local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function()
      local Me = { }
      attach_methods(Me, Interface)
      return Me
    end
end

Interface =
  {
    create = create,
    Write = write,
    GetString = get_string,
  }

-- Export:
return create()

--[[
  2024 # # # #
  2025 #
  2026 # #
  2026-10-14
]]
