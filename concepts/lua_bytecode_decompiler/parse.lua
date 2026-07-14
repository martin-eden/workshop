-- Return strings tree with bytecode instructions for function

--[[
  Author: Martin Eden
  Last mod.: 2026-07-14
]]

--[[
  Basically it's wrapper over text output from "luac" program.
]]

-- Imports:
local compile = request('compile')
local get_listing = request('parse.get_listing')
local StringStream = request('!.concepts.StreamIo.Input.String')
local LinesStream = request('!.concepts.StreamIo.Input.Lines')
local parse_listing = request('parse.parse_listing')

local parse =
  function(func)
    assert_function(func)

    local bytecode_str = compile(func)

    local listing_str = get_listing(bytecode_str)

    -- print(listing_str)

    local StringStream = new(StringStream)
    StringStream:Init(listing_str)

    local LinesStream = new(LinesStream)
    LinesStream:Init(StringStream)

    return parse_listing(LinesStream)
  end

-- Export:
return parse

--[[
  2026-07-12
  2026-07-13
  2026-07-14
]]
