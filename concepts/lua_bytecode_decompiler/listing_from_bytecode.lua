-- Return strings tree with bytecode instructions for bytecode string

--[[
  Author: Martin Eden
  Last mod.: 2026-10-19
]]

--[[
  Basically it's wrapper over text output from "luac" program.
]]

local get_listing = request('listing_from_bytecode.get_listing')
local InputStringStream = request('!.concepts.StreamIo.Input.String')
local InputLinesStream = request('!.concepts.StreamIo.Input.Lines')
local parse_listing = request('listing_from_bytecode.parse_listing')

return
  function(bytecode_str)
    local listing_str = get_listing(bytecode_str)

    local InputLines
    do
      local InputString = new(InputStringStream)
      InputString:Init(listing_str)

      InputLines = new(InputLinesStream)
      InputLines:Init(InputString)
    end

    return parse_listing(InputLines)
  end

--[[
  2026 # # #
]]
