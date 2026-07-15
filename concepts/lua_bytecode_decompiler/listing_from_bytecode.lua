-- Return strings tree with bytecode instructions for bytecode string

--[[
  Author: Martin Eden
  Last mod.: 2026-07-15
]]

--[[
  Basically it's wrapper over text output from "luac" program.
]]

-- Imports:
local get_listing = request('listing_from_bytecode.get_listing')
local StringStream = request('!.concepts.StreamIo.Input.String')
local LinesStream = request('!.concepts.StreamIo.Input.Lines')
local parse_listing = request('listing_from_bytecode.parse_listing')

local listing_from_bytecode =
  function(bytecode_str)
    assert_string(bytecode_str)

    local listing_str = get_listing(bytecode_str)

    -- print(listing_str)

    local StringStream = new(StringStream)
    StringStream:Init(listing_str)

    local LinesStream = new(LinesStream)
    LinesStream:Init(StringStream)

    return parse_listing(LinesStream)
  end

-- Export:
return listing_from_bytecode

--[[
  2026-07-12
  2026-07-13
  2026-07-14
]]
